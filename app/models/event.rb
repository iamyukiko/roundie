class Event < ApplicationRecord

  has_many :applies
  has_many :users, through: :applies
  has_many :event_comments, dependent: :destroy

  # validates :event_date, presence: true
  # validates :deadline_date, presence: true
  # validates :entry_limit, presence: true
  # validates :event_title, presence: true
  # validates :event_introduction, presence: true
  # validates :event_status, presence: true

#イベントの残日数表示
  def date
    date_format = "%Y%m%d"
    (deadline_date.strftime(date_format).to_i - Date.today.strftime(date_format).to_i)
  end

  def is_owned_by?(user)
    owner_id == user.id
  end


#開催エリアの選択用
  enum event_area:{
     "---":0,
     北海道:1,青森県:2,岩手県:3,宮城県:4,秋田県:5,山形県:6,福島県:7,
     茨城県:8,栃木県:9,群馬県:10,埼玉県:11,千葉県:12,東京都:13,神奈川県:14,
     新潟県:15,富山県:16,石川県:17,福井県:18,山梨県:19,長野県:20,
     岐阜県:21,静岡県:22,愛知県:23,三重県:24,
     滋賀県:25,京都府:26,大阪府:27,兵庫県:28,奈良県:29,和歌山県:30,
     鳥取県:31,島根県:32,岡山県:33,広島県:34,山口県:35,
     徳島県:36,香川県:37,愛媛県:38,高知県:39,
     福岡県:40,佐賀県:41,長崎県:42,熊本県:43,大分県:44,宮崎県:45,鹿児島県:46,
     沖縄県:47
   }

  enum search_score:{beginner:0, middle:1, athlete:2, low_handicap:3}


end