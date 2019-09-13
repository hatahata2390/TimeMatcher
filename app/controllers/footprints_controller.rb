class FootprintsController < ApplicationController
  # Define Start  
  before_action :logged_in_user

  # Action Start
  def show
    @users = User.find(current_user.id).footprints.search(params[:search]).page(params[:page])
    display_error_if_empty(@users,'No footprint','list_user_path(current_user)')    
  end

end
