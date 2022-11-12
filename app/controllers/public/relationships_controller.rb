class Public::RelationshipsController < ApplicationController

  def create
    current_user.follow(params[:user_id])
    redirect_to request.referer
  end

  def destroy
    current_user.unfollow(params[:user_id])
    redirect_to request.referer
  end

#フォローしている人の一覧を取得する際に使用
  def followings
    user = User.find(params[:user_id])
    @users = user.followings
  end

#フォローされている人の一覧を取得する際に使用
  def followers
     user = User.find(params[:user_id])
     @users = user.followers
  end
end