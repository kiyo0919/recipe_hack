class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  has_many :recipes, dependent: :destroy
  has_many :ingredients, through: :recipes #ユーザーが持つレシピの材料をuser.ingredientsで参照できるようにする
  has_many :stock_foods, dependent: :destroy
  has_many :favorites, dependent: :destroy
  has_many :recipe_comments, dependent: :destroy
  has_many :notifications, dependent: :destroy

  has_one_attached :profile_image

  has_many :follower, class_name: "Relationship", foreign_key: "follower_id", dependent: :destroy # ① フォローしている人取得(Userのfollowerから見た関係)
  has_many :followed, class_name: "Relationship", foreign_key: "followed_id", dependent: :destroy # ② フォローされている人取得(Userのfolowedから見た関係)

  has_many :followings, through: :follower, source: :followed # 自分がフォローしている人,  フォローする人(follower)は中間テーブル(Relationshipのfollower)を通じて(through)、フォローされる人(followed)と紐づく
  has_many :followers, through: :followed, source: :follower # 自分をフォローしている人(自分がフォローされている人),  フォローされる人(followed) は中間テーブル(Relationshipのfollowed)を通じて(through)、 フォローする人(follower) と紐づく


  with_options presence: true do
    validates :last_name
    validates :first_name
    validates :last_name_kana
    validates :first_name_kana
    validates :nick_name
    validates :postal_code
    validates :address
    validates :phone_number
    validates :birth_date
  end

  def follow(user_id)
    follower.create(followed_id: user_id)
  end

  def unfollow(user_id)
    follower.find_by(followed_id: user_id).destroy
  end

  def following?(user)
    followings.include?(user)
  end

def get_profile_image(width, height)
  unless profile_image.attached?
    file_path = Rails.root.join("app/assets/images/no_image.png")
    profile_image.attach(io: File.open(file_path),filename: "default-image.jpg",content_type: "image/jpeg")
  end
  profile_image.variant(resize_to_fill: [width, height]).processed
end

end

