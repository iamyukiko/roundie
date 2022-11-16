class Public::EventsController < ApplicationController
  include ApplicationHelper

  def join
    @event = Event.find(params[:event_id])
    # user_ids = @event.user_ids
    # user_ids.push(current_user.id)
    apply = @event.applies.find_by(user_id: current_user.id) #申請の確認
    if apply.nil? #nilだった場合、申請を作成
      @apply_create = @event.applies.new(user_id: current_user.id, apply_status: :applying).save
      redirect_to event_path(@event.id), notice: "申請しました"
    elsif apply.applying?
      redirect_to event_path(@event.id), notice: "申請中です"
    elsif apply.approved?
      user_ids = @event.user_ids
  　　user_ids.push(current_user.id)
      # @event.update(user_ids: user_ids)
       redirect_to event_path(@event.id), notice: "承認されています"
    elsif apply.rejected?
      redirect_to event_path(@event.id), notice: "却下されています"
    else
      redirect_to event_path(@event.id), alert: "失敗"
      # redirect_to event_path(@event.id), alert: @event.errors.full_messages.join(" ")
    end
  end

  def new
    @event = Event.new
  end

  def create
    @event = Event.new(event_params)
    @event.owner_id = current_user.id
    @event.users << current_user
      if @event.save
         redirect_to event_path(@event.id)
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
    @events = Event.search(
      title: params[:event_title],
      gender: params[:gender],
      date_from: date_select_params_to_date(:date_from),
      date_to: date_select_params_to_date(:date_to),
      area: params[:area],
      search_score: params[:search_score],
      entry_limit: params[:entry_limit])
  end

  def show
    @event = Event.find(params[:id])
    @owner = User.find(@event.owner_id)
    @event_users = @event.users
    @event_comment = EventComment.new
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
