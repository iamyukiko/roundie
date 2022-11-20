class Public::AppliesController < ApplicationController

  def index
    # @owned_events = Event.find(owner_id: current_user.id)
    @applies = Apply.joins(:event).where(event:{ owner_id: current_user.id}, apply_status:[:applying, :rejected]).order(updated_at: :desc).page(params[:page]) #ログインしている人にする
  end

  def update
    @apply = Apply.find(params[:id]) #フォームでもURLでも取れる
    if params[:apply][:apply_status] == 'approved'
      if @apply.event.entry_limit.to_i < Apply.where(event_id: params[:event_id], apply_status: :approved).count+1
        redirect_to index_apply_path(current_user.id), alert: "イベントの規定人数を超えています"
      else
        @apply.update(apply_status: :approved)
        redirect_to index_apply_path(current_user.id), notice: "承認しました"
      end
    elsif params[:apply][:apply_status] == 'rejected'
        @apply.update(apply_status: :rejected)
         redirect_to index_apply_path(current_user.id), alert: "申請を却下しました"
    elsif params[:apply][:apply_status] == 'applying'
        @apply.update(apply_status: :applying)
        redirect_to index_apply_path(current_user.id), alert: "申請中に変更しました"
    end
  end

end
