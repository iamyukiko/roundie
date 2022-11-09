class Public::UsersController < ApplicationController

  def show
    @user = current_user
  end

  def edit
    @user = current_user
  end

  def update
    @user = current_user
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
