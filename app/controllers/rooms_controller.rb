class RoomsController < ApplicationController

  before_action :authenticate_user!

  def index
        @rooms = current_user.rooms.includes(:messages).order("messages.created_at desc")
    end

    def create
        @room = Room.create
        #Entriesテーブルにuser_id(current_user.id)と参加するroom_idの情報を入れる
        @joinCurrentUser = Entry.create(user_id: current_user.id, room_id: @room.id)
        #参加するユーザー（/users/showで表示していたuser_id）の情報を入れる
        @joinUser = Entry.create(join_room_params)
        #作成したroom_idにリダイレクト
        redirect_to room_path(@room.id)
    end


    private
    def join_room_params
        params.require(:entry).permit(:user_id, :room_id).merge(room_id: @room.id)
    end

end
