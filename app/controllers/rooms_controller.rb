class RoomsController < ApplicationController
# Define Start  
  before_action :logged_in_user
  before_action :correct_room,   only: [:show]

# Action Start  
  def index
    @rooms = current_user.rooms.page(params[:page])
    if @rooms.empty?
      flash[:warning] = 'temp'
      redirect_to root_url
    end
  end

  def show
    @room = Room.find(params[:id])
    @users = @room.users.where("user_id != ?", current_user.id)
    @messages = @room.messages
  end
  
  private

    # Before Action Start
    # Compare params[:id], session(cookies)[:user_id]
    def correct_room
      @hoge = Room.find(params[:id])
      @hoges = @hoge.users
      render :file => "#{Rails.root}/public/404.html", layout: false, status: :not_found unless @hoges.include?(current_user)
    end

end
