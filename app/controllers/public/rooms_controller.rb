class Public::RoomsController < ApplicationController

  def create
    rooms = Room.all.map{|o| {id: o.id, entries: o.entries.pluck(:user_id) }}
    room = rooms.select{|o| o[:entries].sort == [current_user.id, params[:owner_id].to_i].sort }.first
    if room.present?
      @room = Room.find(room[:id])
    else
      @room = current_user.rooms.build
      if @room.save
        Entry.create!(room_id: @room.id, user_id: current_user.id)
        Entry.create!(room_id: @room.id, user_id: params[:owner_id])
      end
    end
    redirect_to room_path(@room)
  end

  def show
    @room = Room.find(params[:id])
    @messages = @room.messages
    @message = Message.new
    @user = @room.entry_users.where.not(id: current_user.id).first
  end

  def index
   current_entries = current_user.entries
   my_room_id = []
     current_entries.each do |entry|
       my_room_id << entry.room.id
     end
   @another_entries = Entry.where(room_id: my_room_id).where.not(user_id: current_user.id).page(params[:page])
  end

end
