class Product < ApplicationRecord
  validates :title, :price, presence: true
  has_many :purchases
  scope :is_active, -> { where(is_archived: false) }
end
