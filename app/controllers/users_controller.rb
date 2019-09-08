class UsersController < ApplicationController
  # Define Start  
  before_action :logged_in_user, only: [:index, :list, :show, :edit, :update, :destroy, :like_sending, :like_receiving]
  before_action :correct_user,   only: [:list, :edit, :update, :like_sending, :like_receiving]
  before_action :admin_user,     only: [:index, :destroy]

  # Action Start
  def index
    @users = User.page(params[:page])
  end

  def show
    @user = User.find(params[:id])
  end

  def list
    @user = User.find(params[:id])
    @users = User.where(
      ["activated = :activated and gender != :gender",
        {activated: true, gender: @user.gender}
      ]
    ).search(params[:search]).page(params[:page])
  end
  
  def new
    @user = User.new
  end
  
  def create
    @user = User.new(user_params)
    if @user.save
      @user.send_activation_email
      flash[:info] = "Please check your email to activate your account."
      redirect_to root_url
    else
      #redirect_to new_user_url
      render "new"
    end
  end
  
  def edit
    @user = User.find(params[:id])
  end
  
  def update
    if @user.update_attributes(user_params)
      flash[:success] = "Profile updated"
      redirect_to @user
    else
      render "edit"
    end
  end
  
  def destroy
    User.find(params[:id]).destroy
    flash[:success] = "User deleted"
    redirect_to users_url
  end

  def like_sending
    @user  = User.find(params[:id])
    @users = @user.like_sending.page(params[:page])
    render "list"
    # render 'show_likes'
  end

  def like_receiving
    @user  = User.find(params[:id])
    @users = @user.like_receiving.page(params[:page])
    render "list"
    # render 'show_likes'
  end
  
    private
  
    # Strong Parameters
    def user_params
      params.require(:user).permit(:gender, :name, :email, :password, :password_confirmation, :avater, :comment, :search)
    end
  
    # Before Action Start
    # Compare params[:id], session(cookies)[:user_id]
    def correct_user
      @user = User.find(params[:id])
      render :file => "#{Rails.root}/public/404.html", layout: false, status: :not_found unless current_user?(@user)
    end 

    # Check Admin
    def admin_user
      render :file => "#{Rails.root}/public/404.html", layout: false, status: :not_found unless current_user.admin?
    end

end