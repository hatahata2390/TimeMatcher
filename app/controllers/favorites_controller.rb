class FavoritesController < ApplicationController
# Define Start  
  before_action :logged_in_user

# Action Start
  def create
    user = User.find(params[:favorite_user_id])
    @favorite = Favorite.new(owner_user_id: current_user.id, favorite_user_id: user.id)
    if @favorite.save
      flash[:success] = "Success to add Favorite!"
    else
      flash[:danger] = "Fail to add Favorite."
    end
    redirect_to list_user_path(current_user)
  end

  def show
    @user = User.find(current_user.id)
    @users = @user.favorites.search(params[:search]).page(params[:page])
  end  

end
