class StockFood < ApplicationRecord
  belongs_to :user
  validates :name, presence: true
  has_one :notification, dependent: :destroy
end
