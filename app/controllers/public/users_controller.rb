class Public::UsersController < ApplicationController

  def show
    @user = User.find(params[:id])
    if params[:type] == 'owner'
      @events = Event.where(owner_id: @user.id)
    else
     @events = @user.events
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
