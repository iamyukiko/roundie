class EventComment < ApplicationRecord
  belongs_to :user
  belongs_to :event

  validates :comment, presence: true

#通知用
  has_one :activity, as: :subject, dependent: :destroy

  after_create_commit :create_activities

  private

  def create_activities #コメントをした際通知
    event.users.each do |user|
      Activity.create!(subject: self, user_id: user.id, action_type: :commented_to_own_event)
    end
  end

end
