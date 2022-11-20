class Admin::EventsController < ApplicationController

  def index
    @events = Event.all
  end

  def show
    @event = Event.find(params[:id])
    @owner = User.find(@event.owner_id)
    @event_users = @event.approved_users
  end

  def edit
    @event = Event.find(params[:id])
  end

  def update
    @event = Event.find(params[:id])
    @event.attributes = event_params #attribute = 各カラムにコピー
    if @event.save(context: :admin) #
      redirect_to admin_event_path(@event.id)
    else
      render "edit"
    end
  end

  private

  def event_params
    params.require(:event).permit(:owner_id, :event_area, :event_date, :deadline_date, :entry_limit, :age, :event_title, :event_introduction, :event_status, :search_score)
  end

end
