class LikeRelationshipsController < ApplicationController
  # Define Start  
  before_action :logged_in_user

  # Action Start
  def create
    user = User.find(params[:like_receiver_id])
    current_user.like(user)
    if current_user.matching?(user)
      Room.create!(name: "#{current_user.email}#{user.email}")
      @room = Room.find_by(name: "#{current_user.email}#{user.email}")
      UserRoomRelationship.create!(user_id: current_user.id, room_id: @room.id)
      UserRoomRelationship.create!(user_id: user.id, room_id: @room.id)
      redirect_to list_user_path(current_user)
    else
      redirect_to list_user_path(current_user)
    end
  end

end
