class Public::EventsController < ApplicationController

  def new
    @event = Event.new
  end

  def create
    @event = Event.new(event_params)
    @event.owner_id = current_user.id
      if @event.save
         redirect_to events_path
      else
        render 'new'
      end
  end
  
  def show
  end
  

  private

  def event_params
    params.require(:event).permit(:owner_id, :event_area, :event_date, :deadline_date, :entry_limit, :age, :event_title, :event_introduction, :event_status, :search_score)
  end

end
