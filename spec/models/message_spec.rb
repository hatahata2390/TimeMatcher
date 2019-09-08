require 'rails_helper'

RSpec.describe Message, type: :model do
  let(:room) {FactoryBot.create(:sample_room)}

  describe 'Validation Check' do

    it "is valid with a chat" do
      message = room.messages.new(chat: "test")
      expect(message).to be_valid
    end

    it "is not valid without a chat" do
      message = room.messages.new(chat: nil)
      expect(message).to_not be_valid
    end

  end

end
