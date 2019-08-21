class MatchersController < ApplicationController

  def index
    @users = current_user.matchers
    if @users.empty?
      flash[:warning] = 'temp'
      redirect_to root_url
    end
  end

  def show
    @user = User.find(params[:id])
  end

end
