require 'rails_helper'

RSpec.describe 'Like functuon', type: :system do
  let!(:ami) {FactoryBot.create(:ami)}
  let!(:bob) {FactoryBot.create(:bob)}

  # scenario "Successful edit with friendly forwarding" do
  #   login_and_visit_list_user_path(ami)
  #   expect {click_button 'Like!'}.to change(LikeRelationship, :count).by(1)
  #   expect {click_button 'Like!'}.not_to change{Room.count}
  #   expect(current_path).to eq list_user_path(current_user)
  # end

  # scenario "Successful edit with friendly forwarding" do
  #   login_and_visit_list_user_path(ami)
  #   expect {click_button 'Like!'}.to change(LikeRelationship, :count).by(1)
  #   login_and_visit_list_user_path(bob)
  #   expect {click_button 'Like!'}.to change(LikeRelationship, :count).by(1)
  #   expect {click_button 'Like!'}.to change(Room, :count).by(1)
  #   expect(current_path).to eq user_path(ami)
  # end

#   def login_and_visit_list_user_path(user)
#     visit login_path
#     fill_in 'Email', with: user.email
#     fill_in 'Password', with: user.password
#     click_button 'Log in'
#     visit list_user_path(user)
#   end

# end