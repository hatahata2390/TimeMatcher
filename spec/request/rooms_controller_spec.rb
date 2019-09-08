require 'rails_helper'

RSpec.describe'Check Response rooms_controllor', type: :request do
  before do
    @ami = FactoryBot.create(:ami)
    @bob = FactoryBot.create(:bob)
    @ami_room = FactoryBot.create(:sample_room)
    @bob_room = FactoryBot.create(:sample_room)
    UserRoomRelationship.create!(user_id: @ami.id, room_id: @ami_room.id)
    UserRoomRelationship.create!(user_id: @bob.id, room_id: @bob_room.id)
  end

  describe "Without login" do

    it "returns http success when GET rooms#index without login" do
      get rooms_path
      expect(flash[:danger]).not_to eq nil
      expect(response).to redirect_to login_path
    end

    it "returns http success when GET rooms#show without login" do
      get room_path(@ami_room.id)
      expect(flash[:danger]).not_to eq nil
      expect(response).to redirect_to login_path
    end
  
  end

  describe "With login" do

    it "success when GET rooms#index with login" do  
      get login_path
      post login_path, params: { session: {email: @ami.email, password: @ami.password, remember_me: 0 } }
      expect(session[:user_id]).to eq @ami.id
      get rooms_path
      expect(flash[:danger]).to eq nil
      expect(response).to have_http_status(:success)
    end

    it "success when GET rooms#show with login" do  
      get login_path
      post login_path, params: { session: {email: @ami.email, password: @ami.password, remember_me: 0 } }
      expect(session[:user_id]).to eq @ami.id
      get room_path(@ami_room.id)
      expect(flash[:danger]).to eq nil
      expect(response).to have_http_status(:success)
    end

  end
  
  describe "With login by other user" do

    it "returns 404 when GET rooms#show with login by other user" do  
      get login_path
      post login_path, params: { session: {email: @ami.email, password: @ami.password, remember_me: 0 } }
      expect(session[:user_id]).to eq @ami.id
      get rooms_path(@bob_room.id)
      expect(flash[:danger]).to eq nil
      expect(response).to have_http_status(404)
    end

  end

end