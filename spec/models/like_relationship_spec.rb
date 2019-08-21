require 'rails_helper'

RSpec.describe LikeRelationship, type: :model do
  let(:user_a) {FactoryBot.create(:active_user)}
  let(:user_b) {FactoryBot.create(:active_user, email: "active2@com")}
  
  describe 'Validation Check' do
    before do
      @likerelationship = LikeRelationship.new(like_sender_id: user_a.id, like_receiver_id: user_b.id)
    end

    it "is valid with like_sender_id and like_receiver_id" do
      expect(@likerelationship).to be_valid
    end

    it "is not valid when like_sender_id is nil" do
      @likerelationship.like_sender_id = nil
      expect(@likerelationship).not_to be_valid
    end

    it "is not valid when like_receiver_id is nil" do
      @likerelationship.like_receiver_id = nil
      expect(@likerelationship).not_to be_valid
    end

  end

end
