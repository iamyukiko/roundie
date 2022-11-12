class User < ApplicationRecord

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_one_attached :image
  has_many :applies
  has_many :events, through: :applies
  has_many :event_comments, dependent: :destroy
  has_many :messages, dependent: :destroy
  has_many :entries, dependent: :destroy
  has_many :rooms, dependent: :destroy

  #フォローされる設定
  has_many :reverse_of_relationships, class_name: "Relationship", foreign_key: "followed_id", dependent: :destroy
  has_many :followers, through: :reverse_of_relationships, source: :follower

  #フォローする設定
  has_many :relationships, class_name: "Relationship", foreign_key: "follower_id", dependent: :destroy
  has_many :followings, through: :relationships, source: :followed

  #フォローしたときの設定
  def follow(user_id)
    relationships.create(followed_id: user_id)
  end

  #フォローを外すときの設定
  def unfollow(user_id)
    relationships.find_by(followed_id: user_id).destroy
  end

  #フォローをしているか確認
  def following?(user)
    followings.include?(user)
  end

  #プロフィール画像の設定
  def get_image
    unless image.attached?
      file_path = Rails.root.join('app/assets/images/no_image.jpg')
      image.attach(io: File.open(file_path), filename: 'default-image.jpg', content_type: 'image/jpeg')
    end
      image
  end
  #年齢の算出
  def age
    date_format = "%Y%m%d"
    (Date.today.strftime(date_format).to_i - birthdate.strftime(date_format).to_i) / 10000
  end

  #性別の選択用
  enum gender:{male:0, female:1, others:2}

  #ユーザー平均スコアの選択用
  enum user_score:{beginner:0, middle:1, athlete:2, low_handicap:3}

  #居住地の選択用
  enum user_area:{
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

end