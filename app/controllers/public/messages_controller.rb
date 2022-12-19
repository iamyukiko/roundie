class Public::MessagesController < ApplicationController

  def create
    @message = current_user.messages.build(message_params)
    @room = @message.room

    if @message.save
      flash[:notice] = "投稿しました"
      redirect_to room_path(@room)
    else
      @messages = @room.messages
      @user = @room.entry_users.where.not(id: current_user.id).first
      flash[:alert] = "メッセージ送信に失敗しました。"
       redirect_to room_path(@room)
    end
  end

  private

  def message_params
    params.require(:message).permit(:body, :room_id)
  end

end