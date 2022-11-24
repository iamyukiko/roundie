class Activity < ApplicationRecord

#polymorphic=どのモデルからでも関連づけられる
  belongs_to :subject, polymorphic: true

#通知のアクション用
  enum action_type: {
    commented_to_own_event: 0,
    messaged_me: 1,
    followed_me: 2,
    updated_apply_status: 3,
  }

#既読管理用
  enum read: {
    unread: false,
    read: true,
  }

end
