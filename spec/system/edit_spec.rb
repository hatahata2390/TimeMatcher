require 'rails_helper'

RSpec.describe 'Edit functuon', type: :system do
  let!(:negative_user) {FactoryBot.create(:negative_user)}
  let!(:active_user) {FactoryBot.create(:active_user)}

  scenario "Fail to edit when Name is blank" do
    login_and_visit_edit_path(active_user)
    fill_in_contents(nil,'new@com',nil,nil)
    expect_user_not_updated
    expect(active_user.reload.email).not_to eq 'new@com'
  end

  scenario "Fail to edit when Email is blank" do
    login_and_visit_edit_path(active_user)
    fill_in_contents('new',nil,nil,nil)
    expect_user_not_updated
    expect(active_user.reload.name).not_to eq 'new'
  end

  scenario "Fail to edit when Email has already been taken" do
    login_and_visit_edit_path(active_user)
    fill_in_contents(nil,'negative@com',nil,nil)
    expect_user_not_updated
    expect(active_user.reload.email).not_to eq 'negative@com'
  end

  scenario "Fail to edit when Password confirmation doesn't match Password" do
    login_and_visit_edit_path(active_user)
    fill_in_contents(nil,nil,'newnew','bbbbbb')
    expect_user_not_updated
    # expect(active_user.reload.password).not_to eq 'newnew'    
  end

  scenario "Success to edit Name" do
    login_and_visit_edit_path(active_user)
    fill_in 'Name', with: 'new'
    expect_user_updated
    expect(active_user.reload.name).to eq 'new'
  end

  scenario "Success to edit Email" do
    login_and_visit_edit_path(active_user)
    fill_in 'Email', with: 'new@com'
    expect_user_updated
    expect(active_user.reload.email).to eq 'new@com'
  end

  scenario "Success to edit Password" do
    login_and_visit_edit_path(active_user)
    fill_in 'Password', with: 'newnew'
    fill_in 'Password confirmation', with: 'newnew'
    expect_user_updated
    # expect(active_user.reload.password).to eq 'newnew'
  end

  def login_and_visit_edit_path(user)
    visit login_path
    fill_in 'Email', with: user.email
    fill_in 'Password', with: user.password
    click_button 'Log in'
    visit edit_user_path(user)
  end

  def fill_in_contents(name,email,password,password_confirmation)
    fill_in 'Name', with: name
    fill_in 'Email', with: email
    fill_in 'Password', with: password
    fill_in 'Password confirmation', with: password_confirmation
  end

  def expect_user_updated
    aggregate_failures do
      click_button 'Edit Profile!'
      expect(page).to have_content 'updated'
      expect(page).not_to have_content 'error'
    end
  end

  def expect_user_not_updated
    aggregate_failures do
      click_button 'Edit Profile!'
      expect(page).not_to have_content 'updated'
      expect(page).to have_content 'error'
    end
  end

end