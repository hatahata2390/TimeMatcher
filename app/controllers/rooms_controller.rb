class RoomsController < ApplicationController
# Define Start  
  before_action :logged_in_user
  before_action :correct_room,   only: [:show]

# Action Start  
  def index
    @rooms = current_user.rooms.page(params[:page])
    display_error_if_empty(@rooms,'No matcher','list_user_path(current_user)')
  end

  def show
    @room = Room.find(params[:id])
    @users = @room.users.where("user_id != ?", current_user.id)
    @messages = @room.messages
  end
  
  private

    # Before Action Start
    # Check user belong to room or not
    def correct_room
      @hoge = Room.find(params[:id])
      @hoges = @hoge.users
      render :file => "#{Rails.root}/public/404.html", layout: false, status: :not_found unless @hoges.include?(current_user)
    end

end
