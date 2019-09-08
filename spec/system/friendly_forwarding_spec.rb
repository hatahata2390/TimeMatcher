require 'rails_helper'

RSpec.describe 'Friendly Forwarding functuon', type: :system do
  let(:ami) {FactoryBot.create(:Ami)}

  scenario "Successful edit with friendly forwarding" do
    visit edit_user_path(ami)
    expect(page).to have_content 'Please log in.'
    expect(current_path).to eq login_path
    fill_in 'Email', with: ami.email
    fill_in 'Password', with: ami.password
    click_button 'Log in'
    expect(current_path).to eq edit_user_path(ami)
  end

end