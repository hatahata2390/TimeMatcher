require 'rails_helper'

RSpec.describe'Check Response like_relatinoships_controllor', type: :request do
  let!(:ami) {FactoryBot.create(:ami)}
  let!(:bob) {FactoryBot.create(:bob)}

  describe "Without login" do

    it "returns http success when GET rooms#index without login" do
      post like_relationships_path, params: { like_receiver_id: bob.id }
      expect(flash[:danger]).not_to eq nil
      expect(flash[:success]).to eq nil
      expect(response).to redirect_to login_path
    end
  
  end

  describe "With login" do

    it "success when GET rooms#index with login" do  
      get login_path
      post login_path, params: { session: {email: ami.email, password: ami.password, remember_me: 0 } }
      expect(session[:user_id]).to eq ami.id
      post like_relationships_path, params: { like_receiver_id: bob.id }
      expect(flash[:danger]).to eq nil
      expect(flash[:success]).not_to eq nil
      expect(response).to redirect_to list_user_path(ami)
    end

  end

end