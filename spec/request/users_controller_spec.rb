require 'rails_helper'

RSpec.describe'Check Response users_controllor', type: :request do
  let!(:ami) {FactoryBot.create(:ami)}
  let!(:bob) {FactoryBot.create(:bob)}
  let!(:admin) {FactoryBot.create(:admin_user)}

  describe "Without login" do

    it "success when GET users#new without login" do
      get new_user_path
      expect(flash[:danger]).to eq nil
      expect(response).to have_http_status(:success)
    end

    it "success when POST users#create without login" do
      post login_path, params: { session: {email: 'ami@com', password: 'dddddd' } }
      expect(flash[:danger]).to eq nil
      expect(response).to redirect_to list_user_path(ami)
    end

    it "redirects root when GET users#index without login" do
      get users_path
      expect(flash[:danger]).not_to eq nil
      expect(response).to redirect_to login_path
    end

    it "redirects root when GET users#show without login" do
      get user_path(ami)
      expect(flash[:danger]).not_to eq nil
      expect(response).to redirect_to login_path
    end

    it "redirects root when GET users#list without login" do
      get list_user_path(ami)
      expect(flash[:danger]).not_to eq nil
      expect(response).to redirect_to login_path
    end

    it "redirects login_path when GET users#edit without login" do
      get edit_user_path(ami)
      expect(flash[:danger]).not_to eq nil
      expect(response).to redirect_to login_path
    end

    it "redirects root GET users#like_sending without login" do
      get like_sending_user_path(ami)
      expect(flash[:danger]).not_to eq nil
      expect(response).to redirect_to login_path
    end

    it "redirects root GET users#like_receiving without login" do
      get like_receiving_user_path(ami)
      expect(flash[:danger]).not_to eq nil
      expect(response).to redirect_to login_path
    end

    it "redirects login_path when PATCH users#update without login" do
      patch user_path(ami), params: { user: {name: ami.name, email: ami.email } }
      expect(flash[:danger]).not_to eq nil
      expect(response).to redirect_to login_path
    end

    it "redirects login_path when DELETE users#destroy without login" do
      expect{delete user_path(ami)}.not_to change(User, :count)
      expect(flash[:danger]).not_to eq nil
      expect(flash[:success]).to eq nil
      expect(response).to redirect_to login_path
    end
  
  end

  describe "With login" do

    it "success when GET users#list with login" do  
      get login_path
      post login_path, params: { session: {email: ami.email, password: ami.password, remember_me: 0 } }
      expect(session[:user_id]).to eq ami.id
      get list_user_path(ami)
      expect(flash[:danger]).to eq nil
      expect(response).to have_http_status(:success)
    end

    it "success when GET users#like_sending with login" do  
      get login_path
      post login_path, params: { session: {email: ami.email, password: ami.password, remember_me: 0 } }
      expect(session[:user_id]).to eq ami.id
      get like_sending_user_path(ami)
      expect(flash[:danger]).to eq nil
      expect(response).to have_http_status(:success)
    end

    it "success when GET users#like_receiving with login" do  
      get login_path
      post login_path, params: { session: {email: ami.email, password: ami.password, remember_me: 0 } }
      expect(session[:user_id]).to eq ami.id
      get like_receiving_user_path(ami)
      expect(flash[:danger]).to eq nil
      expect(response).to have_http_status(:success)
    end

    it "success when GET users#edit with login" do  
      get login_path
      post login_path, params: { session: {email: ami.email, password: ami.password, remember_me: 0 } }
      expect(session[:user_id]).to eq ami.id
      get edit_user_path(ami)
      expect(flash[:danger]).to eq nil
      expect(response).to have_http_status(:success)
    end

    it "success when PATCH users#update with login" do  
      get login_path
      post login_path, params: { session: {email: ami.email, password: ami.password, remember_me: 0 } }
      expect(session[:user_id]).to eq ami.id
      patch user_path(ami), params: { user: {name: ami.name, email: ami.email } }
      expect(flash[:danger]).to eq nil
      expect(response).to redirect_to user_path(ami)
    end

  end
  
  describe "With login by other user" do

    it "returns 404 when GET users#list with login by other user" do  
      get login_path
      post login_path, params: { session: {email: ami.email, password: ami.password, remember_me: 0 } }
      expect(session[:user_id]).to eq ami.id
      get list_user_path(bob)
      expect(flash[:danger]).to eq nil
      expect(response).to have_http_status(404)
    end

    it "returns 404 when GET users#like_sending with login by other user" do  
      get login_path
      post login_path, params: { session: {email: ami.email, password: ami.password, remember_me: 0 } }
      expect(session[:user_id]).to eq ami.id
      get like_sending_user_path(bob)
      expect(flash[:danger]).to eq nil
      expect(response).to have_http_status(404)
    end

    it "returns 404 when GET users#like_receiving with login by other user" do  
      get login_path
      post login_path, params: { session: {email: ami.email, password: ami.password, remember_me: 0 } }
      expect(session[:user_id]).to eq ami.id
      get like_receiving_user_path(bob)
      expect(flash[:danger]).to eq nil
      expect(response).to have_http_status(404)
    end        

    it "returns 404 when GET users#edit with login by other user" do  
      get login_path
      post login_path, params: { session: {email: ami.email, password: ami.password, remember_me: 0 } }
      expect(session[:user_id]).to eq ami.id
      get edit_user_path(bob)
      expect(flash[:danger]).to eq nil
      expect(response).to have_http_status(404)
    end

    it "returns 404 when PATCH users#update with login by other user" do  
      get login_path
      post login_path, params: { session: {email: ami.email, password: ami.password, remember_me: 0 } }
      expect(session[:user_id]).to eq ami.id
      patch user_path(bob), params: { user: {name: bob.name, email: bob.email } }
      expect(flash[:danger]).to eq nil
      expect(response).to have_http_status(404)
    end

  end

  describe "With login by admin user" do

    it "success when GET users#index with login by admin user" do  
      get login_path
      post login_path, params: { session: {email: admin.email, password: admin.password, remember_me: 0 } }
      expect(session[:user_id]).to eq admin.id
      get users_path
      expect(flash[:danger]).to eq nil
      expect(response).to have_http_status(:success)
    end

    it "success when DELETE users#destroy with login by admin user" do  
      get login_path
      post login_path, params: { session: {email: admin.email, password: admin.password, remember_me: 0 } }
      expect(session[:user_id]).to eq admin.id
      expect{delete user_path(ami)}.to change{User.count}.by(-1)
      expect(flash[:danger]).to eq nil
      expect(flash[:success]).not_to eq nil
      expect(response).to redirect_to users_url
    end
    
  end

  describe "With login by not admin user" do

    it "returns 404 when GET users#index with login by admin user" do  
      get login_path
      post login_path, params: { session: {email: ami.email, password: ami.password, remember_me: 0 } }
      expect(session[:user_id]).to eq ami.id
      get users_path
      expect(flash[:danger]).to eq nil
      expect(response).to have_http_status(404)
    end    

    it "returns 404 when DELETE users#destroy with login by not admin user" do  
      get login_path
      post login_path, params: { session: {email: ami.email, password: ami.password, remember_me: 0 } }
      expect(session[:user_id]).to eq ami.id
      expect{delete user_path(bob)}.not_to change(User, :count)
      expect(flash[:danger]).to eq nil
      expect(flash[:success]).to eq nil
      expect(response).to have_http_status(404)
    end
    
  end

end