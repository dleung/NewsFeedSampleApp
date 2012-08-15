require 'spec_helper'

describe Pet do
  sample_data_loader
  
  it "name pet should return correctly" do 
    pet_1.name.should == "Bobby"
  end
  
  it "pet without name should not be valid" do
    pet = Pet.new
    pet.should_not be_valid
  end

  it "pet with inappropiate name should not be valid" do
    pet = Pet.new(name: "fuck")
    pet.should_not be_valid
  end
end