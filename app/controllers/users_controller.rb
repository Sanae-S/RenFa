class UsersController < ApplicationController

  def show
    @user = User.find(params[:id])
      if user_signed_in?
      #current_userが既にルームに参加してるか判断
      @currentUserEntry = Entry.where(user_id: current_user.id)
      #表示しているユーザーがルームに参加してるか判断
      @userEntry = Entry.where(user_id: @user.id)
      #@userとcurrent_userが違うユーザーであることを確認
      unless @user.id == current_user.id
        #current_userが参加してる全てのルームidを出力
        @currentUserEntry.each do |cu|
          #@userが参加してる全てのルームidを出力
          @userEntry.each do |u|
            #current_userの参加してるroom_idと@userのroom_idで一致するものがあるのか判断
            if cu.room_id == u.room_id
              #もし部屋が作成されてなかったら
              @haveRoom = true #既にルームがあるという意味の変数
              @roomId = cu.room_id #ルームにアクセスするための変数
            end
          end
        end
        #もし部屋が作成されてなかったら
        unless @haveRoom
          @room = Room.new
          @entry = Entry.new
        end
      end
    end
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

  def search
    @user_or_post_image = params[:option]
    if @user_or_post_image == "1"
      #テキストで入力された値と、選択された方の値を引数としてモデルに送る。
      @users = User.search(params[:search], @user_or_post_image)
    else
      @post_images = PostImage.search(params[:search], @user_or_post_image)
    end
  end

private
  def user_params
    params.require(:user).permit(:name, :user_info, :email, :address, :admin)
  end
end
