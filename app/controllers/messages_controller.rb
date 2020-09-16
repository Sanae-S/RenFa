class MessagesController < ApplicationController

  before_action :set_room, only: [:create, :edit, :update, :destroy]
  before_action :set_message, only: [:update, :destroy]

  def create
    if Entry.where(user_id: current_user.id, room_id: @room.id)
      @message = Message.create(message_params)
        if @message.save
           @message = Message.new
           gets_entries_all_messages
        end
        redirect_to room_path(@room.id)
    else
      flash[:alert] = "メッセージの送信に失敗しました"
    end
  end

  def update
    if @message.update(message_params)
        gets_entries_all_messages
    end
  end

  def destroy
    if @message.destroy
       gets_entries_all_messages
    end
    redirect_to room_path(@room.id)
  end

  private


    def set_room
      #form_withで送られたroom_idの情報を取得
        @room = Room.find(params[:message][:room_id])
    end

    def set_message
      #form_withで送られたroom_idの情報を取得
        @message = Message.find(params[:id])
    end

    #非同期通信する場合は,一覧表示のため,この記述が必ず必要
    def gets_entries_all_messages
      #メッセージを全件取得
        @messages = @room.messages.includes(:user).order("created_at asc")
        #ルームに参加してる人たち
        @entries = @room.entries
    end

    def message_params
      #新しく送られたメッセージを取得
        params.require(:message).permit(:user_id, :message, :room_id).merge(user_id: current_user.id)
    end
end
