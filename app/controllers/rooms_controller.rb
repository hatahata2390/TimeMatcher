class RoomsController < ApplicationController

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
    # @room = Room.find(params[:id])
    # @messages = @room.messages
  end

end
