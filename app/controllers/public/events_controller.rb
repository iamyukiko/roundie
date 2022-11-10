class Public::EventsController < ApplicationController



  def join
    @event = Event.find(params[:event_id])
    @event.users << current_user
    redirect_to event_path(@event.id)
  end

  def new
    @event = Event.new
  end

  def create
    @event = Event.new(event_params)
    @event.owner_id = current_user.id
    @event.users << current_user
      if @event.save
         redirect_to events_path
      else
        render 'new'
      end
  end

  def destroy
    @event = Event.find(params[:id])
    @event.users.delete(current_user)
    redirect_to event_path(@event.id)
  end

  def index
    @events = Event.all
  end

  def show
    @event = Event.find(params[:id])
    @event_users = @event.users
  end

  def edit
    @event = Event.find(params[:id])
  end

  def update
    @event = Event.find(params[:id])
    if @event.update(event_params)
      redirect_to event_path(@event.id)
    else
      render "edit"
    end
  end

  private

  def event_params
    params.require(:event).permit(:owner_id, :event_area, :event_date, :deadline_date, :entry_limit, :age, :event_title, :event_introduction, :event_status, :search_score)
  end

end
