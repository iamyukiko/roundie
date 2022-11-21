class Message < ApplicationRecord
  belongs_to :user
  belongs_to :room

  validates :body, presence: true

#通知用
  has_one :activity, as: :subject, dependent: :destroy

  after_create_commit :create_activities

  private

  def create_activities
    #byebug
    Activity.create!(subject: self, user_id: self.room.entries.pluck(:user_id).select{|user_id| user_id != self.user_id }.first, action_type: :messaged_me)
  end

end
