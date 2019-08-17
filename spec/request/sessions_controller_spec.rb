require 'rails_helper'

RSpec.describe'Login', type: :request do
  let(:negative_user) {FactoryBot.create(:negative_user)}
  let(:active_user) {FactoryBot.create(:active_user)}

  describe "GET #new" do
    it "returns http success" do
      get login_path
      expect(response).to have_http_status(:success)
    end
  end

  describe "Login by user who is not exist" do
    it "fails login" do
      get login_path
      post login_path, params: { session: {email: 'notexist', password: 'notexist' } }
      expect(flash[:danger]).not_to eq nil
      expect(flash[:warning]).to eq nil
      expect(response).to have_http_status(:success)
    end
  end

  describe "Login by user who is not activated" do
    it "fails login" do
      get login_path
      post login_path, params: { session: {email: negative_user.email, password: negative_user.password } }
      expect(flash[:danger]).to eq nil
      expect(flash[:warning]).not_to eq nil
      expect(response).to redirect_to root_path
    end
  end

  describe "Login by user who is activated without Remember me and Logout" do
    it "successes and not save cookies, deletes session when logout" do
      get login_path
      post login_path, params: { session: {email: active_user.email, password: active_user.password, remember_me: 0 } }
      expect(session[:user_id]).to eq active_user.id
      expect(cookies[:user_id]).to eq nil
      expect(cookies[:remember_token]).to eq nil
      expect(session[:forwarding_url]).to eq nil
      delete logout_path
      expect(response).to have_http_status "302"
      expect(response).to redirect_to root_path
      expect(session[:user_id]).to eq nil
      expect(cookies[:user_id]).to eq nil
      expect(cookies[:remember_token]).to eq nil
    end
  end

  describe "Login by user who is activated with Remember me and Logout" do
    it "successes and save cookies, deletes session and cookies when logout" do
      get login_path
      post login_path, params: { session: {email: active_user.email, password: active_user.password, remember_me: 1  } }
      expect(session[:user_id]).not_to eq nil
      expect(cookies[:user_id]).not_to eq nil
      expect(cookies[:remember_token]).not_to eq nil
      expect(session[:forwarding_url]).to eq nil
      delete logout_path
      expect(response).to have_http_status "302"
      expect(response).to redirect_to root_path
      expect(session[:user_id]).to eq nil
      expect(cookies[:user_id]).to eq ""
      expect(cookies[:remember_token]).to eq ""
    end
  end

end