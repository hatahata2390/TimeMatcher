require 'rails_helper'

RSpec.describe Room, type: :model do
  let(:user) {FactoryBot.create(:active_user)}
  let(:room) {FactoryBot.create(:sample_room)}

  describe 'Check destruction of associated records' do
    before do
      UserRoomRelationship.create!(user_id: user.id, room_id: room.id)
      room.messages.create!(chat: "test")
    end

    it "changes count of Message" do
      expect{room.destroy}.to change{Message.count}.by(-1)
    end

    it "changes count of UserRoomRelationship" do
      expect{room.destroy}.to change{UserRoomRelationship.count}.by(-1)
    end

  end

end
