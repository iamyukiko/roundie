class Public::AppliesController < ApplicationController

  def index
    # @owned_events = Event.find(owner_id: current_user.id)
    @applies = Apply.joins(:event).where(event:{ owner_id: params[:current_user_id]}, apply_status: :applying) #ログインしている人にする
  end

  def update
  end

  def destroy
  end

end
