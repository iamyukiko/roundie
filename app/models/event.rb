class Event < ApplicationRecord

  has_many :applies
  has_many users, through: :applies

  # validates :event_date, presence: true
  # validates :deadline_date, presence: true
  # validates :entry_limit, presence: true
  # validates :event_title, presence: true
  # validates :event_introduction, presence: true
  # validates :event_status, presence: true

end
