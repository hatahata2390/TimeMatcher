require 'rails_helper'

RSpec.describe 'Test links in Top page', type: :system do
  scenario "Title" do
    visit_and_click_link('Time Matcher')
    expect(current_path).to eq root_path
  end

  scenario "Home" do
    visit_and_click_link('Home')
    expect(current_path).to eq root_path
  end

  scenario "Log in" do
    visit_and_click_link('Log in')
    expect(current_path).to eq login_path
  end

  scenario "Sign up now!" do
    visit_and_click_link('Sign up now!')
    expect(current_path).to eq new_user_path
  end

  scenario "About" do
    visit_and_click_link('About')
    expect(current_path).to eq '/about'
  end

  scenario "Contact" do
    visit_and_click_link('Contact')
    expect(current_path).to eq '/contact'
  end

  def visit_and_click_link(link)
    visit root_path
    click_link link
  end
end