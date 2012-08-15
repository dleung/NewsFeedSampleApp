require 'spec_helper'

describe Message do
  sample_data_loader
  
  it "name of message should return correctly" do 
    message_1.name.should == "Contents of message 1"
  end
  
  it "message without name should not be valid" do
    message = Message.new
    message.should_not be_valid
  end

  it "message with inappropiate name should not be valid" do
    message = Message.new(name: "Shit")
    message.should_not be_valid
  end
end