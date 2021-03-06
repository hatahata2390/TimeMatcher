require 'rails_helper'

RSpec.describe 'Login/Logout function', type: :system do
  let(:negative_user) {FactoryBot.create(:negative_user)}
  let(:active_user) {FactoryBot.create(:active_user)}

  scenario "Fail to login by negative user" do
    visit_and_fill_in(negative_user)
    click_button 'Log in'
    expect(current_path).to eq root_path
    expect(page).to have_link 'Log in'
    expect(page).not_to have_link 'Find'
    expect(page).not_to have_link 'Matchers'
    expect(page).not_to have_link 'Profile'
    expect(page).not_to have_link 'Log out'
  end

  scenario "Success to login by active user" do
    visit_and_fill_in(active_user)
    click_button 'Log in'
    expect(current_path).to eq list_user_path(active_user)
    expect(page).not_to have_link 'Log in'
    expect(page).to have_link 'Find'
    expect(page).to have_link 'Matchers'
    expect(page).to have_link 'Profile'
    expect(page).to have_link 'Log out'
    click_link 'Log out'
    expect(current_path).to eq root_path
    expect(page).to have_link 'Log in'
    expect(page).not_to have_link 'Find'
    expect(page).not_to have_link 'Matchers'
    expect(page).not_to have_link 'Profile'
    expect(page).not_to have_link 'Log out'
  end

  def visit_and_fill_in(user)
    visit login_path
    fill_in 'Email', with: user.email
    fill_in 'Password', with: user.password
  end

end