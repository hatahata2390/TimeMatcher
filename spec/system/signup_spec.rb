require 'rails_helper'

RSpec.describe 'ユーザー登録機能', type: :system do
  include ActiveJob::TestHelper

  scenario "未入力、またはパスワード不一致時登録不可" do
    visit new_user_path
    choose 'Male'
    fill_in_contents(nil,nil,nil,nil)
    expect_user_not_created

    visit new_user_path
    choose 'Male'
    fill_in_contents('ad',nil,nil,nil)
    expect_user_not_created

    visit new_user_path
    choose 'Male'
    fill_in_contents('ad','ad@com',nil,nil)
    expect_user_not_created

    visit new_user_path
    choose 'Male'
    fill_in_contents('ad','ad@com','aaaaaa',nil)
    expect_user_not_created

    visit new_user_path
    choose 'Male'
    fill_in_contents('ad','ad@com','aaaaaa','bbbbbb')
    expect_user_not_created

    visit new_user_path
    fill_in_contents('ad','ad@com','aaaaaa','aaaaaa')
    expect_user_not_created
  end

  scenario "全件入力時かつパスワード一致時のみ登録可能" do
    visit new_user_path
    choose 'Female'
    fill_in_contents('ad','ad@com','aaaaaa','aaaaaa')
    expect_user_created
  end

  def fill_in_contents(name,email,password,password_confirmation)
    fill_in 'Name', with: name
    fill_in 'Email', with: email
    fill_in 'Password', with: password
    fill_in 'Password confirmation', with: password_confirmation
  end

  def expect_user_not_created
    aggregate_failures do
      expect {click_button 'Create my account'}.to_not change(User, :count)
      expect(page).to have_content 'The form contains'
    end
  end

  def expect_user_created
    perform_enqueued_jobs do
      expect {click_button 'Create my account'}.to change(User, :count).by(1)
      expect(current_path).to eq root_path
      expect(page).to_not have_content 'The form contains'
      @user = User.find_by(email: 'ad@com')
      expect(@user.activated).to eq false
      expect(@user.activation_digest).not_to eq nil
    end

    mail = ActionMailer::Base.deliveries.last
    aggregate_failures do
      expect(mail.to).to eq ['ad@com']
      expect(mail.from).to eq ['TM@example.com']
      expect(mail.subject).to eq 'Account activation'
    end
  end

end