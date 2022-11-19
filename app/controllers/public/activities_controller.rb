class Public::ActivitiesController < ApplicationController

  def index
    @activities = current_user.activities.order(updated_at: :desc)
  end

end
