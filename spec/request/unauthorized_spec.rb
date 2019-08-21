require 'rails_helper'

RSpec.describe'Check Unauthorized User', type: :request do
  let!(:negative_user) {FactoryBot.create(:negative_user)}
  let!(:active_user) {FactoryBot.create(:active_user)}

  describe "GET users#index without login" do
    it "redirects root" do
      get users_path
      expect(response).to redirect_to login_path
    end
  end

  describe "GET users#show without login" do
    it "redirects root" do
      get user_path(active_user)
      expect(response).to redirect_to login_path
    end
  end

  describe "GET users#list without login" do
    it "redirects root" do
      get list_user_path(active_user)
      expect(response).to redirect_to login_path
    end
  end

  describe "GET users#edit without login" do
    it "redirects login_path" do
      get edit_user_path(active_user)
      expect(flash[:danger]).not_to eq nil
      expect(response).to redirect_to login_path
    end
  end

  describe "GET users#like_sending without login" do
    it "redirects root" do
      get like_sending_user_path(active_user)
      expect(response).to redirect_to login_path
    end
  end

  describe "GET users#like_receiving without login" do
    it "redirects root" do
      get like_receiving_user_path(active_user)
      expect(response).to redirect_to login_path
    end
  end

  describe "PATCH users#update without login" do
    it "redirects login_path" do
      patch user_path(active_user), params: { user: {name: active_user.name, email: active_user.email } }
      expect(flash[:danger]).not_to eq nil
      expect(response).to redirect_to login_path
    end
  end
  
  describe "GET users#edit with login by other user" do
    it "redirects root" do  
      get login_path
      post login_path, params: { session: {email: active_user.email, password: active_user.password, remember_me: 0 } }
      expect(session[:user_id]).to eq active_user.id
      get edit_user_path(negative_user)
      expect(flash[:danger]).to eq nil
      expect(response).to redirect_to root_path
    end
  end

  describe "PATCH users#update with login by other user" do
    it "redirects root" do  
      get login_path
      post login_path, params: { session: {email: active_user.email, password: active_user.password, remember_me: 0 } }
      expect(session[:user_id]).to eq active_user.id
      patch user_path(negative_user), params: { user: {name: active_user.name, email: active_user.email } }
      expect(flash[:danger]).to eq nil
      expect(response).to redirect_to root_path
    end
  end

  describe "DELETE users#destroy without login" do
    it "redirects login_path" do
      expect{delete user_path(negative_user)}.not_to change(User, :count)
      expect(flash[:success]).to eq nil
      expect(response).to redirect_to login_path
    end
  end

  describe "DELETE users#destroy with login by not authorized user" do
    it "redirects root" do  
      get login_path
      post login_path, params: { session: {email: active_user.email, password: active_user.password, remember_me: 0 } }
      expect(session[:user_id]).to eq active_user.id
      expect{delete user_path(negative_user)}.not_to change(User, :count)
      expect(flash[:success]).to eq nil
      expect(response).to redirect_to root_path
    end
  end

end