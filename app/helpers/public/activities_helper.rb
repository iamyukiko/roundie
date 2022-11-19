module Public::ActivitiesHelper

  def transition_path(activity)
    case activity.action_type.to_sym
    when :commented_to_own_event
      event_path(activity.subject.event)
    when :messaged_me
      room_path(activity.subject.room)
    when :followed_me
      user_path(activity.subject.follower)
    when :updated_apply_status
      event_path(activity.subject.event)
    end
  end

end