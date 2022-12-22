# frozen_string_literal: true

class Public::SessionsController < Devise::SessionsController
  before_action :reject_inactive_user,only: [:create]

  def guest_sign_in
    user = User.guest
    sign_in user
    redirect_to root_path, notice: 'ゲストユーザーとしてログインしました。'
  end

  protected

  def reject_inactive_user
    @user = User.find_by(email: params[:user][:email])
    if @user
      if @user.valid_password?(params[:user][:password]) && !@user.is_valid
        flash[:alert] = "退会済みです。再度ご登録をしてご利用ください。"
        redirect_to new_user_registration_path
      end
    end
  end

  def after_sign_out_path_for(resource)
    new_user_session_path
  end

end
