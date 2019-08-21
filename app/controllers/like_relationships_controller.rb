class LikeRelationshipsController < ApplicationController
  # Define Start  
  before_action :logged_in_user

  # Action Start
  def create
    user = User.find(params[:like_receiver_id])
    current_user.like(user)
    redirect_to user
  end

end
