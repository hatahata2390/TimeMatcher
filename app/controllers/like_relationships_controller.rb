class LikeRelationshipsController < ApplicationController
  # Define Start  
  before_action :logged_in_user

  # Action Start
  def create
    user = User.find(params[:like_receiver_id])
    current_user.like(user)
    flash[:success] = "Like sending!"
    if current_user.matching?(user)
      @room = Room.new(name: "#{current_user.email}#{user.email}")
      if @room.save
        @room.add_user(current_user)
        @room.add_user(user)
        flash[:success] = "Matching!"
        redirect_to user_path(user)
      end
    else
      redirect_to list_user_path(current_user)
    end
  end

end
