class UsersController < ApplicationController

  def show
    @user = User.find(params[:id])
  end

  def edit
  	@user = User.find(params[:id])
  end

  def update
  	@user = User.find(params[:id])
  	if @user.update(user_params)
       redirect_to user_path(@user)
    else
       render :edit
    end
  end


  def hide
    @user = User.find(params[:id])
    #is_deletedカラムにフラグを立てる
    @user.update(is_deleted: true)
    #ログアウトさせる
    reset_session
    flash[:notice] = "ありがとうございました。またのご利用を心よりお待ちしております。"
    redirect_to root_path
  end

private
  def user_params
  	params.require(:user).permit(:name, :user_info, :email, :address, :admin)
  end
end
