require 'rails_helper'

RSpec.describe User, type: :model do
  let(:user) {FactoryBot.create(:negative_user)}
  let(:ami) {FactoryBot.create(:ami)}
  let(:bob) {FactoryBot.create(:bob)}

  describe 'Validation Check' do

    it "is valid with a name, email, and password" do
      expect(user).to be_valid
    end

    it "is not valid when gender is nil" do
      user.gender = nil
      expect(user).to_not be_valid
    end

    it "is not valid when name is nil" do
      user.name = nil
      expect(user).to_not be_valid
    end

    it "is not valid when email is nil" do
      user.email = nil
      expect(user).to_not be_valid
    end

    it "is not valid when password is nil" do
      user.password = nil
      expect(user).to_not be_valid
    end

    it "is not valid when name has more than 50 characters" do
      user.name = "a" * 51
      expect(user).to_not be_valid
    end

    it "is valid when name has less than 50 characters" do
      user.name = "a" * 49
      expect(user).to be_valid
    end

    it "is not valid when email has more than 50 characters" do
      user.name = "a" * 47 + "@com"
      expect(user).to_not be_valid
    end

    it "is valid when email has less than 50 characters" do
      user.name = "a" * 45 + "@com"
      expect(user).to be_valid
    end

    it "is not allowed duplicate email address" do
      dupuser_A = FactoryBot.create(:negative_user)
      dupuser_B = FactoryBot.build(:negative_user, email: "NEGATIVE@com")
      dupuser_B.save
      expect(dupuser_B).to_not be_valid
    end

    it "is not valid when password has less than 6 characters" do
      user.password = "a" * 5
      expect(user).to_not be_valid
    end
  end

  describe 'Check destruction of associated records' do
    
    it "changes count of LikeRelationship when like_sender is destroyed" do
      LikeRelationship.create!(like_sender_id: ami.id, like_receiver_id: bob.id)
      expect{ami.destroy}.to change{LikeRelationship.count}.by(-1)
    end

    it "changes count of LikeRelationship when like_receiver is destroyed" do
      LikeRelationship.create!(like_sender_id: ami.id, like_receiver_id: bob.id)
      expect{bob.destroy}.to change{LikeRelationship.count}.by(-1)
    end

  end

  describe 'Class Method Check' do

    it "returns token when call new_token" do
      expect(User.new_token).not_to be be_empty
    end

    it "returns token when call new_token" do
      expect(User.digest("aaaaaa")).not_to be_empty
    end
  end

  describe 'Instance Method Check' do
    
    it "returns true when call remember and authenticated?" do
      aggregate_failures do
        user.remember
        expect(user.remember_token).not_to eq nil
        expect(user.remember_digest).not_to eq nil
        expect(user.authenticated?(:remember, user.remember_token)).to eq true
      end
    end
    
    it "returns true when call forger" do
      expect(user.forget).to eq true
    end
    
    it "returns true when call activate" do
      expect(user.activate).to eq true
    end


    it "returns true when call create_reset_digest" do
      expect(user.create_reset_digest).to eq true
    end

    it "works correctly when call like, like_send_to?, like_sent_by? and matching?" do
      expect(ami.like_send_to?(bob)).not_to eq true
      expect(ami.like_sent_by?(bob)).not_to eq true
      expect(bob.like_send_to?(ami)).not_to eq true
      expect(bob.like_sent_by?(ami)).not_to eq true
      expect(ami.matching?(bob)).not_to eq true
      expect(bob.matching?(ami)).not_to eq true
      ami.like(bob)
      expect(ami.like_send_to?(bob)).to eq true
      expect(ami.like_sent_by?(bob)).not_to eq true
      expect(bob.like_send_to?(ami)).not_to eq true
      expect(bob.like_sent_by?(ami)).to eq true
      expect(ami.matching?(bob)).not_to eq true
      expect(bob.matching?(ami)).not_to eq true
      bob.like(ami)
      expect(ami.like_send_to?(bob)).to eq true
      expect(ami.like_sent_by?(bob)).to eq true
      expect(bob.like_send_to?(ami)).to eq true
      expect(bob.like_sent_by?(ami)).to eq true
      expect(ami.matching?(bob)).to eq true
      expect(bob.matching?(ami)).to eq true
    end   

  end

  describe 'Private Method Check' do
    it "works correctly when call downcase_email" do
      user.email = 'NEGATIVE@com'
      downcase_email = 'negative@com'
      expect(user.send(:downcase_email)).to eq downcase_email
    end

    it "returns true when call new_token" do
      expect(user.send(:create_activation_digest)).not_to be_empty
    end
  end

end