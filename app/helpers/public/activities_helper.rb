module Public::ActivitiesHelper

  def transition_path(activity) #ビュー・コントローラーからの呼び出し両パターンを想定
    case activity.action_type.to_sym
      when :commented_to_own_event
        if 0 < self.methods.grep(/event_path/).count
          event_path(activity.subject.event) #ビューから呼ばれたときはこちらの処理
        else
          Rails.application.routes.url_helpers.event_path(activity.subject.event) #コントローラーからヘルパーメソッドを呼んだときは↑のパスが使用できないためこちら
        end
      when :messaged_me
        if 0 < self.methods.grep(/room_path/).count
          room_path(activity.subject.room)
        else
          Rails.application.routes.url_helpers.room_path(activity.subject.room)
        end
      when :followed_me
        if 0 < self.methods.grep(/user_path/).count
          user_path(activity.subject.follower)
        else
         Rails.application.routes.url_helpers.user_path(activity.subject.follower)
        end
      when :updated_apply_status
        if 0 < self.methods.grep(/event_path/).count
            event_path(activity.subject.event)
        else
          Rails.application.routes.url_helpers.event_path(activity.subject.event)
        end
      end
  end

  def unread_activities
    @activities = current_user.activities.where(read: false)
  end

end
