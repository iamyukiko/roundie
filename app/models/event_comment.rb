class EventComment < ApplicationRecord
  belongs_to :user
  belongs_to :event

  validates :comment, presence: true

#通知用
  has_one :activity, as: :subject, dependent: :destroy

  after_create_commit :create_activities

  private

#コメントした際の通知アクション
  def create_activities
    event.approved_users.each do |to_user|
     if to_user.id != user.id #送り先 != コメントした人
      Activity.create!(subject: self, user_id: to_user.id, action_type: :commented_to_own_event)
     end
    end
  end

end
