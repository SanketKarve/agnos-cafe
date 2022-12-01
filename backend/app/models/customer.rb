class Customer < ApplicationRecord
  validates :name, :phone_number, presence: true
  validates :phone_number, presence: { message: 'Please enter valid phone number.' },
                           numericality: true,
                           length: { minimum: 10, maximum: 15 }
  has_many :purchases
  has_many :orders
  scope :is_active, -> { where(is_archived: false) }
end
