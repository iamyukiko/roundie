class Apply < ApplicationRecord

  belongs_to :user
  belongs_to :event

  has_one :activity, as: :subject, dependent: :destroy


  after_create_commit :create_activities

  enum apply_status: {
    applying: 1, #申請中
    approved: 2, #承認
    rejected: 3 #却下
  }

  private

  def create_activities　#applyステータスはアップデート。
    Activity.create!(subject: self, user: event.apply, action_type: :updated_apply_status)
  end


end
