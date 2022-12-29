module Public::AppliesHelper

  # 既読用
  def unchecked_applies
    @applies = Apply.joins(:event).where(event:{ owner_id: current_user.id }, apply_status:[:applying])
  end

end
