require 'rails_helper'

RSpec.describe UserRoomRelationship, type: :model do
  let(:user) {FactoryBot.create(:active_user)}
  let(:room) {FactoryBot.create(:sample_room)}
  
  describe 'Validation Check' do
    before do
      @user_room_relationship = UserRoomRelationship.new(user_id: user.id, room_id: room.id)
    end

    it "is valid with user_id and room_id" do
      expect(@user_room_relationship).to be_valid
    end

    it "is not valid when user_id is nil" do
      @user_room_relationship.user_id = nil
      expect(@user_room_relationship).not_to be_valid
    end

    it "is not valid when room_id is nil" do
      @user_room_relationship.room_id = nil
      expect(@user_room_relationship).not_to be_valid
    end

  end

end
