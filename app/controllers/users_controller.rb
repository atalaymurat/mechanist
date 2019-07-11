class UsersController < ApplicationController
  before_action :authenticate_user!
  def index
    @users = User.order(:id).all
  end

  def edit
    @user = User.find(params[:id])
  end

  def update_password
    @user = current_user
    if @user.update_with_password(user_params)
      bypass_sign_in(@user)
      redirect_to users_path
    else
      render "edit"
    end
  end

  private
  def user_params
    params.require(:user).permit(:email, :admin, :password, :password_confirmation, :current_password)
  end
end
