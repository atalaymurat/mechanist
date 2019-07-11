class UsersController < ApplicationController
  before_action :authenticate_user!

  def index
    @users = User.order(:id).all
  end

  def edit
    @user = User.find(params[:id])
  end

  def show
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])
    if params[:user][:remove_user_picture] == "1"
      @user.remove_user_picture!
      @user.save
    end  
    if params[:user][:password].blank?
      params[:user].delete(:password)
      params[:user].delete(:password_confirmation)
    end
      
    if current_user.admin
      @user.update_attributes(admin_user_params)
      flash[:notice] = "#{@user.email} was successfully updated by admin"
    elsif current_user.approved
      @user.update_with_password(user_params)
      flash[:notice] = "#{@user.email} was successfully updated"
    end

    redirect_to users_path
  end

  def destroy
    if current_user.admin
      @user = User.find(params[:id])
      @user.destroy
      flash[:notice] = "#{@user.email} was successfully deleted"
    end
    redirect_to users_path
  end

  private
  def user_params
    params.require(:user).permit(:email, :user_picture, :remote_user_picture_url, :first_name, :last_name, :alias, :password, :password_confirmation, :current_password)
  end
  def admin_user_params
    params.require(:user).permit(:email, :user_picture, :remote_user_picture_url, :first_name, :last_name, :alias,  :admin, :password, :password_confirmation, :approved)
  end
end
