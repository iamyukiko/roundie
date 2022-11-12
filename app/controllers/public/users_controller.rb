class Public::UsersController < ApplicationController

  def show
    @user = User.find(params[:id])
    
    @currentUserEntry=Entry.where(user_id: current_user.id) #ログインユーザーをEntryに記録するために探す
    @userEntry=Entry.where(user_id: @user.id) #チャットボタンをクリックされたユーザーをEntryに記録するために探す
      unless @user.id == current_user.id
        @currentUserEntry.each do |currentuser|
          @userEntry.each do |user|
            if currentuser.room_id == user.room_id then #roomが作成されている場合
              @isRoom = true
              @roomId = currentuser.room_id
            end
          end
        end
        unless @isRoom #roomが作成されていない場合
          @room = Room.new
          @entry = Entry.new
        end
      end

    if params[:type] == 'owner' #ユーザーマイページで主催イベントを表示
      @events = Event.where(owner_id: @user.id)
    else
     @events = @user.events #違う場合は参加イベントを表示
    end
  end

  def join_events
    @user = User.find(params[:id])
    @events = @user.events
    render :show
  end

  def owner_events
    @user = User.find(params[:id])
    @events = Event.where(owner_id: @user.id)
    render :show
  end


  def edit
    @user = User.find(params[:id])
  end

  def update
     @user = User.find(params[:id])
    if @user.update(user_params)
      redirect_to user_path(@user.id)
    else
      render :edit
    end
  end

  def unsubscribe
  end

  private

  def user_params
    params.require(:user).permit(:email,:user_name,:gender,:user_score,:nickname,:birthdate,:user_area,:self_introduction,:is_valid,:image)
  end
end