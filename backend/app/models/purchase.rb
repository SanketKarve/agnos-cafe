class Purchase < ApplicationRecord
  belongs_to :customer
  belongs_to :product
  belongs_to :order
  scope :is_active, -> { where(is_archived: false) }
end
