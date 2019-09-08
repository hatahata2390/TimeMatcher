require 'rails_helper'

RSpec.describe 'Like functuon', type: :system do
  before do
    @ami = FactoryBot.create(:ami)
    @bob = FactoryBot.create(:bob)
    @ami_room = FactoryBot.create(:sample_room)
    @bob_room = FactoryBot.create(:sample_room)
    UserRoomRelationship.create!(user_id: @ami.id, room_id: @ami_room.id)
    UserRoomRelationship.create!(user_id: @bob.id, room_id: @bob_room.id)
  end

  scenario "Successful edit with friendly forwarding" do
    visit login_path
    fill_in 'Email', with: @ami.email
    fill_in 'Password', with: @ami.password
    click_button 'Log in'
    visit rooms_path(@bob_room.id)
    expect(response).to have_http_status(404)  
  end
end