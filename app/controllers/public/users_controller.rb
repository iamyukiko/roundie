class Public::UsersController < ApplicationController

  def show
    @user = User.find(params[:id])
    @events = @user.events
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
