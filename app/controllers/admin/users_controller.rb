class Admin::UsersController < ApplicationController

  def index
    @users = User.page(params[:page])
  end

  def show
    @user = User.find(params[:id])
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])
    if @user.update(user_params)
      redirect_to admin_users_path
    else
      render edit_admin_user_path
    end
  end

private

  def user_params
    params.require(:user).permit(:name, :user_info, :email, :address, :admin,:is_deleted)
  end

end
