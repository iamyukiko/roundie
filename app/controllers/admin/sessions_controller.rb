class Admin::SessionsController < Devise::SessionsController

  def guest_sign_in
    admin = Admin.guest
    sign_in admin
    redirect_to admin_path, notice: 'ゲストユーザーとしてログインしました。'
  end

  def configure_sign_in_params
    devise_parameter_sanitizer.permit(:sign_in, keys: [:attribute])
  end

  protected

  def after_sign_in_path_for(resource)
    admin_path
  end

  def after_sign_out_path_for(resource)
    new_admin_session_path
  end

end
