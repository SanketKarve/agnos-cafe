class Order < ApplicationRecord
  belongs_to :customer
  has_many :payments
  has_many :purchases
  scope :is_active, -> { where(is_archived: false) }
end
