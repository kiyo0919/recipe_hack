class Recipe < ApplicationRecord
  belongs_to :user
  belongs_to :genre
  has_many :ingredients, dependent: :destroy
  accepts_nested_attributes_for :ingredients, allow_destroy: true
  has_many :steps, dependent: :destroy
  accepts_nested_attributes_for :steps, allow_destroy: true
  has_many :favorites, dependent: :destroy
  has_many :recipe_comments, dependent: :destroy
  has_many :recipe_tags, dependent: :destroy
  has_many :tags, through: :recipe_tags

  has_one_attached :image

  with_options presence: true do
    validates :title
    validates :catch_phrase
  end

  validates :title,  length: { maximum: 17 }

  def favorited_by?(user)
    favorites.where(user_id: user.id).exists?
  end

  def get_recipe_image(width, height)
    unless image.attached?
      file_path = Rails.root.join("app/images/no_recipe_image.png")
      image.attach(io: File.open(file_path),filename: "default-image.jpg",content_type: "image/jpeg")
    end
    image.variant(resize_to_fill: [width, height]).processed
  end

  def save_tag(sent_tags)
    # タグが存在していれば、タグの名前を配列として全て取得
    current_tags = self.tags.pluck(:name) unless self.tags.nil?
    # 現在取得したタグから送られてきたタグを除いてoldtagとする
    old_tags = current_tags - sent_tags
    # 送信されてきたタグから現在存在するタグを除いたタグをnewとする
    new_tags = sent_tags - current_tags
    # 古いタグを消す
    old_tags.each do |old|
      self.tags.delete Tag.find_by(name: old)
    end
    # 新しいタグを保存
    new_tags.each do |new|
      new_recipe_tag = Tag.find_or_create_by(name: new)
      self.tags << new_recipe_tag
    end
  end



end
