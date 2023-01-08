class Admin::EventsController < ApplicationController
  before_action :authenticate_admin!

  def index
    @events = Event.page(params[:page])
  end

  def show
    @event = Event.find(params[:id])
    @owner = User.find(@event.owner_id)
    @event_users = @event.approved_users
  end

  def edit
    @event = Event.find(params[:id])
    @event.update_status
  end

  def update
    @event = Event.find(params[:id])
    @event.attributes = event_params # attribute = 各カラムにコピー
    if @event.save(context: :admin)
      redirect_to admin_event_path(@event.id), notice: '更新しました'
    else
      render 'edit'
    end
  end

  private

  def event_params
    params.require(:event).permit(:owner_id, :event_area, :event_date, :deadline_date, :entry_limit, :age, :event_title, :event_introduction, :event_status, :search_score)
  end
end
