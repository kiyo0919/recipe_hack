class Recipe < ApplicationRecord
  belongs_to :user
  belongs_to :genre
  has_many :ingredients, dependent: :destroy
  accepts_nested_attributes_for :ingredients, allow_destroy: true
  has_many :steps, dependent: :destroy
  accepts_nested_attributes_for :steps, allow_destroy: true
  has_many :favorites, dependent: :destroy
  has_many :recipe_comments, dependent: :destroy

  has_one_attached :image

  def favorited_by?(user)
    favorites.where(user_id: user.id).exists?
  end

  def get_recipe_image(width, height)
    unless image.attached?
      file_path = Rails.root.join("app/images/no_recipe_image.png")
      image.attach(io: File.open(file_path),filename: "default-image.jpg",content_type: "image/jpeg")
    end
    image.variant(resize_to_limit: [width, height]).processed
  end


end
