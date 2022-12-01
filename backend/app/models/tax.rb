class Tax < ApplicationRecord
  validates :name, :percent, :start_date, :end_date, presence: true
  validate :end_date_after_start_date?

  scope :is_active, -> { where(is_archived: false) }

  def end_date_after_start_date?
    return unless end_date < start_date

    errors.add :end_date, 'must be after start date'
  end
end
