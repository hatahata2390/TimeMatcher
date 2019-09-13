class FavoritesController < ApplicationController
  # Define Start  
  before_action :logged_in_user

  # Action Start
  def create
    @favorite = Favorite.new(owner_user_id: current_user.id, favorite_user_id: params[:favorite_user_id])
    if @favorite.save
      flash[:success] = "Success to add Favorite!"
    else
      flash[:danger] = "Fail to add Favorite."
    end
    redirect_to request.referrer || list_user_path(current_user)
  end

  def show
    @user = User.find(current_user.id)
    @users = @user.favorites.search(params[:search]).page(params[:page])
  end

  def destroy
    Favorite.find_by(owner_user_id: current_user.id, favorite_user_id: params[:favorite_user_id]).destroy
    flash[:success] = "Favorite deleted"
    redirect_to request.referrer || list_user_path(current_user)
  end  

end
