class GroupEvent < ApplicationRecord
  acts_as_paranoid

  validates :start_date, :end_date, :name, presence: true
  validates :name, uniqueness: { case_sensitive: false }
  validate :valid_dates
  validate :eligible_to_publish, on: :update, if: :published_at_changed?

  before_save :calculate_duration

  private

  def calculate_duration
    return if duration

    self.duration = (end_date.to_datetime - start_date.to_datetime).to_i
  end

  def valid_dates
    return errors.add(:base, 'start or end date can not be empty') if end_date.nil? || start_date.nil?
    return if end_date.to_datetime > start_date.to_datetime

    errors.add(:end_date, 'should be greater than start date')
  end

  def eligible_to_publish
    return if name && description && location && start_date && end_date && duration

    errors.add(:publish, 'is only possible when all attributes are present')
  end
end
