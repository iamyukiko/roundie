class Event < ApplicationRecord
  belongs_to :owner, class_name: 'User'
  has_many :applies
  has_many :users, through: :applies
  has_many :approved_users, -> {where(applies: {apply_status: :approved})}, through: :applies, source: :user
  has_many :event_comments, dependent: :destroy

  validates :event_date, presence: true
  validates :deadline_date, presence: true
  validates :entry_limit, presence: true
  validates :event_title, presence: true
  validates :event_introduction, presence: true
  validate :users_must_complete_info, unless: -> { validation_context == :admin } #updateではなくsave時に発火
  validate :event_date_start
  validate :deadline_date_finish

  scope :event_title_like, -> (event_title) { where('event_title LIKE ?', "%#{event_title}%") if event_title.present? }
  scope :gender_is, -> (gender) { where(gender: gender) if gender.present? }
  scope :event_date_from, -> (from) { where('? <= event_date', from) if from.present? }
  scope :event_date_to, -> (to) { where('event_date <= ?', to) if to.present? }
  scope :event_area_is, -> (event_area) { where(event_area: event_area) if event_area.present? }
  scope :search_score_is, -> (search_score) { where(search_score: search_score) if search_score.present? }
  scope :entry_limit_is, -> (entry_limit) { where(entry_limit: entry_limit) if entry_limit.present? }

#検索用
  def self.search(event_title: nil, gender: nil, date_from: nil, date_to: nil, area: nil, search_score: nil, entry_limit: nil)
    event_title_like(event_title)
      .gender_is(gender)
      .event_date_from(date_from)
      .event_date_to(date_to)
      .event_area_is(area)
      .search_score_is(search_score)
      .entry_limit_is(entry_limit)
  end

#イベントの残日数表示
  def date
    (deadline_date - Date.today).to_i
  end

  def is_owned_by?(user)
    owner_id == user.id
  end


#開催エリアの選択用
  enum event_area:{
     北海道:1,青森県:2,岩手県:3,宮城県:4,秋田県:5,山形県:6,福島県:7,
     茨城県:8,栃木県:9,群馬県:10,埼玉県:11,千葉県:12,東京都:13,神奈川県:14,
     新潟県:15,富山県:16,石川県:17,福井県:18,山梨県:19,長野県:20,
     岐阜県:21,静岡県:22,愛知県:23,三重県:24,
     滋賀県:25,京都府:26,大阪府:27,兵庫県:28,奈良県:29,和歌山県:30,
     鳥取県:31,島根県:32,岡山県:33,広島県:34,山口県:35,
     徳島県:36,香川県:37,愛媛県:38,高知県:39,
     福岡県:40,佐賀県:41,長崎県:42,熊本県:43,大分県:44,宮崎県:45,鹿児島県:46,
     沖縄県:47
   }, _prefix: true

 #スコアレベルのeunm
  enum search_score: {
    beginner: 0,
    middle: 1,
    athlete: 2,
    low_handicap: 3,
    every_one: 4
  }, _prefix: true

  private

  #イベント作成時にはプロフィール詳細設定が必要というバリデーション
  def users_must_complete_info
    if owner.user_area.blank? || owner.user_score.blank? || owner.self_introduction.blank?
      errors.add(:base, "プロフィールの詳細設定が必要です。マイページのプロフィール編集から設定してください。")
    end
  end

  #イベント作成日は今日以降の日付で設定というバリデーション
  def event_date_start
    return if event_date.blank?
    errors.add(:event_date, "は今日以降のものを選択してください") if event_date < Date.today
  end

  #募集締め切り日は開催日より8日前以上で設定というバリデーション
  def deadline_date_finish
    return if deadline_date.blank? || event_date.blank?
    unless self.deadline_date + 8.days < self.event_date && deadline_date > Date.today
      errors.add(:deadline_date, "は開催日より8日以上前を選択してください")
    end
  end

end
