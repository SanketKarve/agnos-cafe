class Payment < ApplicationRecord
  validates :mode, :status, presence: true

  belongs_to :order
  scope :is_active, -> { where(is_archived: false) }

  enum mode: { online: 'ONLINE', cash: 'CASH', card: 'CARD' }
  enum status: { success: 'SUCCESSFUL', rejected: 'REJECTED', intiated: 'INITIATED' }
end
