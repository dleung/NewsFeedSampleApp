module SampleLoader
  def sample_data_loader
    let(:user_1) {User.create(name: "Nancy")}
    let(:user_2) {User.create(name: "Bylan")}
    
    let(:message_1) {Message.create(name: "Contents of message 1")}
    
    let(:pet_1) {Pet.create(name: "Bobby")}
  end
end