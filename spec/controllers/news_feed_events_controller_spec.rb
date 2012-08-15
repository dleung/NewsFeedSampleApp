require 'spec_helper'

require 'spec_helper'

describe NewsFeedEventsController do
  sample_data_loader

  it "incorrect object creation" do
    user_1.save
    current_user = user_1
    objects = ["User", "Pet", "Message"]
    objects.each do |object|
      post :create, 
           action_type: "Blah",
           news_feed_object: object,
           news_feed_object_name: "asdfasdf",
           sender: user_1.id
      flash[:notice].should eq("Need to specify correct action")
    end
  end

  it "object should be created correctly" do
    user_1.save
    current_user = user_1
    objects = ["User", "Pet", "Message"]
    objects.each do |object|
      post :create, 
           action_type: "Create",
           news_feed_object: object,
           news_feed_object_name: "asdfasdf",
           sender: user_1.id
      flash[:notice].should eq("#{object} successfully created.")
      news_feed_event = NewsFeedEvent.last
      news_feed_event.text.should == "You have created a #{object}: asdfasdf"
      response.should redirect_to news_feed_events_path
    end
  end
  
  it "object without information should not be created" do
    user_1.save
    current_user = user_1
    objects = ["User", "Pet", "Message"]
    objects.each do |object|
      post :create, 
           action_type: "Create",
           news_feed_object: object,
           news_feed_object_name: "",
           sender: user_1.id
      flash[:notice].should eq("Missing information for #{object}.")
      NewsFeedEvent.all.length.should eq(0)
      response.should redirect_to news_feed_events_path
    end
  end

  it "maximum of 10 objects should be created" do
    user_1.save
    current_user = user_1
    i = 0
    while i < 15
      User.create(name: "blah")
      Pet.create(name: "blah")
      Message.create(name: "blah")
      i += 1
    end
    objects = ["User", "Pet", "Message"]
    objects.each do |object|
      post :create, 
           action_type: "Create",
           news_feed_object: object,
           news_feed_object_name: "Blah blah",
           sender: user_1.id
      flash[:notice].should eq("Can only have a maximum of 10 #{object}.")
      NewsFeedEvent.all.length.should eq(0)
      response.should redirect_to news_feed_events_path
    end
  end

  it "updating user information should work" do
    user_1.save
    message_1.save
    pet_1.save
    current_user = user_1
    post :create, 
         action_type: "Update",
         news_feed_object: "User",
         news_feed_object_name: "New Name",
         sender: user_1.id,
         user_id: user_2.id
    flash[:notice].should eq("User successfully updated.")
    NewsFeedEvent.all.length.should eq(1)
    news_feed_event = NewsFeedEvent.last
    news_feed_event.text.should == "You have updated a User: New Name"
    response.should redirect_to news_feed_events_path
  end

  it "deleting a user should work" do
    user_1.save
    message_1.save
    pet_1.save
    current_user = user_1
    post :create, 
         action_type: "Delete",
         news_feed_object: "User",
         sender: user_1.id,
         user_id: user_2.id
    flash[:notice].should eq("User successfully removed.")
    NewsFeedEvent.all.length.should eq(1)
    news_feed_event = NewsFeedEvent.last
    news_feed_event.text.should == "You have deleted a User: Bylan"
    response.should redirect_to news_feed_events_path
  end

  it "sending a 'user' should work" do
    user_1.save
    message_1.save
    pet_1.save
    current_user = user_1
    post :create, 
         action_type: "Send",
         news_feed_object: "User",
         sender: user_1.id,
         user_id: user_2.id
    flash[:notice].should eq("User successfully sent.")
    NewsFeedEvent.all.length.should eq(1)
    news_feed_event = NewsFeedEvent.last
    news_feed_event.text.should == "You have sent yourself a User: Bylan"
    response.should redirect_to news_feed_events_path
  end

  it "sending a custom message should work should work" do
    user_1.save
    post :create, 
         action_type: "Custom Message",
         news_feed_object: "User",
         sender: user_1.id,
         news_feed_custom: "This is my custom message"
    flash[:notice].should eq("Custom message created.")
    NewsFeedEvent.all.length.should eq(1)
    news_feed_event = NewsFeedEvent.last
    news_feed_event.text.should == "This is my custom message"
    response.should redirect_to news_feed_events_path
  end

end