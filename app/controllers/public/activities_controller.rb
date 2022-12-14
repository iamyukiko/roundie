class Public::ActivitiesController < ApplicationController
  before_action :authenticate_user!

  def index
    @activities = current_user.activities.order(created_at: :desc).page(params[:page])
  end

  # 既読
  def read
    activity = current_user.activities.find(params[:id])
    activity.read! if activity.unread?
    redirect_to ApplicationController.helpers.transition_path(activity) # ヘルパーを呼び出し
  end
end
