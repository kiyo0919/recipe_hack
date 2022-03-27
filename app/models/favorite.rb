class Favorite < ApplicationRecord
  validates_uniqueness_of :recipe_id, scope: :user_id
  belongs_to :user
  belongs_to :recipe
end
