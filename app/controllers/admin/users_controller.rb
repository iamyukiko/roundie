class Admin::UsersController < ApplicationController
  before_action :authenticate_admin!

  def index
    @users = User.page(params[:page])
  end

  def show
    @user = User.find(params[:id])
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])
    if @user.email == 'guest@example.com'
      redirect_to admin_user_path(@user.id), alert: 'ゲストユーザーの更新・削除はできません'
      return
    end
    if @user.update(user_params)
      redirect_to admin_user_path(@user.id), notice: '更新しました'
    else
      render :edit
    end
  end

  private

  def user_params
    params.require(:user).permit(:gender, :password, :email, :user_name, :gender, :user_score, :nickname, :birthdate, :user_area, :self_introduction, :is_valid, :image)
  end
end
