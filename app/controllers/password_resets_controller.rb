class PasswordResetsController < ApplicationController
  # Define Start 
  before_action :get_user,         only: [:edit, :update]
  before_action :valid_user,       only: [:edit, :update]
  before_action :check_expiration, only: [:edit, :update]
  
  # Action Start
  def new
  end
  
  def create
    @user = User.find_by(email: params[:password_reset][:email].downcase)
    if @user
      @user.create_reset_digest
      @user.send_password_reset_email
      flash[:info] = "Email sent with password reset instructions"
      redirect_to root_url
    else
      flash.now[:danger] = "Email address not found"
      render 'new'
    end
  end
  
  def update
    if params[:user][:password].empty?
      @user.errors.add(:password, :blank)
      render 'edit'
    elsif @user.update_attributes(user_params)
      log_in @user
      @user.update_attribute(:reset_digest, nil)
      flash[:success] = "Password has been reset."
      redirect_to @user
    else
      render 'edit'
    end
  end
  
  def edit
  end

    private
  
    # Strong Parameters
    def user_params
    params.require(:user).permit(:password, :password_confirmation)
    end
  
    # Before Action Start
    # Set
    def get_user
      @user = User.find_by(email: params[:email])
    end
  
    # Check Validation of @user
    def valid_user
      unless (@user && @user.activated? && @user.authenticated?(:reset, params[:id]))
        render :file => "#{Rails.root}/public/404.html",  layout: false, status: :not_found
      end
    end
  
    # Check Expiration of reset_token
    def check_expiration
      if @user.password_reset_expired?
        flash[:danger] = "Password reset has expired."
        redirect_to new_password_reset_url
      end
    end

end