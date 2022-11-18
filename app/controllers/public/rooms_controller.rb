class Public::RoomsController < ApplicationController

  def create
    @room = Room.create
    @entry1 = Entry.create(room_id: @room.id, user_id: current_user.id)
    @entry2 = Entry.create(params.require(:entry).permit(:user_id, :room_id).merge(room_id: @room.id))
    redirect_to "/rooms/#{@room.id}"
  end

  def show
    @room = Room.find(params[:id])
    @room.entries.find_or_create_by!(user_id: current_user.id)
    @messages = @room.messages
    @message = Message.new
    @entries = @room.entries
  end

  def index
   current_entries = current_user.entries
   my_room_id = []
     current_entries.each do |entry|
       my_room_id << entry.room.id
     end
   @another_entries = Entry.where(room_id: my_room_id).where.not(user_id: current_user.id)
  end

end
