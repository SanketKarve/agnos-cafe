class TaxGroup < ApplicationRecord
  belongs_to :tax
  scope :is_active, -> { where(is_archived: false) }
end
