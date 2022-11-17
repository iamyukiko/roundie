class Public::EventsController < ApplicationController
  include ApplicationHelper

  def join
    @event = Event.find(params[:event_id])
    apply = @event.applies.find_by(user_id: current_user.id) #申請の確認

    if apply.nil? #nilだった場合、申請を作成
      if @event.entry_limit.to_i < Apply.where(event_id: params[:event_id], apply_status: :approved).count+1
         redirect_to event_path(@event.id), notice: "規定人数を超えています"
      else
        @apply_create = @event.applies.new(user_id: current_user.id, apply_status: :applying).save
        redirect_to event_path(@event.id), notice: "申請しました"
      end
    elsif apply.applying? #申請中になっていいた場合
      redirect_to event_path(@event.id), notice: "申請中です"
    elsif apply.approved?　#承認されている場合は、参加済み＆参加する
      user_ids = @event.user_ids
  　　user_ids.push(current_user.id)
  　　@apply_create = @event.applies.new(user_id: current_user.id, apply_status: :approved).save
       redirect_to event_path(@event.id), notice: "承認されています"
    elsif apply.rejected?　#却下された場合は、nillに戻す
    　@event.apply.users.delete(current_user.id)
      @apply_create = @event.applies.new(user_id: current_user.id, apply_status: :nil).save
      redirect_to event_path(@event.id), notice: "却下されています"
    else
      redirect_to event_path(@event.id), alert: "失敗"
    end
  end

  def new
    @event = Event.new
  end

  def create
    @event = Event.new(event_params)
    @event.owner_id = current_user.id
    @event.users << current_user
      @event.applies.update(apply_status: "approved")
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
      event_title: params[:event_title],
      gender: params[:gender],
      date_from: date_select_params_to_date(:date_from),
      date_to: date_select_params_to_date(:date_to),
      area: params[:area],
      search_score: params[:search_score],
      entry_limit: params[:entry_limit])
  end

  def show
    @room = Room.create
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
