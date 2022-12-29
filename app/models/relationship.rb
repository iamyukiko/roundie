class Relationship < ApplicationRecord
  belongs_to :follower, class_name: 'User'
  belongs_to :followed, class_name: 'User'

  # 通知用
  has_one :activity, as: :subject, dependent: :destroy

  after_create_commit :create_activities

  private

# フォローされた際の通知アクション
  def create_activities
    Activity.create!(subject: self, user_id: followed.id, action_type: :followed_me)
  end

end
