require 'spec_helper'

describe User do
  sample_data_loader
  
  it "name of user should return correctly" do 
    user_1.name.should == "Nancy"
  end
  
  it "user without name should not be valid" do
    user = Message.new
    user.should_not be_valid
  end

  it "user with inappropiate name should not be valid" do
    user = Message.new(name: "bitch")
    user.should_not be_valid
  end
end