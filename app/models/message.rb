class Message < ApplicationRecord
  validates :body, presence: true
  belongs_to :user
  belongs_to :room
  
    #通知用
  has_one :activity, as: :subject, dependent: :destroy
  
  after_create_commit :create_activities

  private
　
  def create_activities　#roomなのかmessageなのかentryなのか
    Activity.create!(subject: self, user: room.user, action_type: :messaged_me)
  end
  
end
