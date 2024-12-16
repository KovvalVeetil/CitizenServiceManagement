class ServiceRequest < ApplicationRecord
  belongs_to :user

  # Validations
  validates :citizen_name, :address, :category, :status, presence: true
  validates :category, inclusion: { in: %w[road_repair waste_management others] }
  validates :status, inclusion: { in: %w[pending resolved escalated] }

  # Scopes for filtering
  scope :pending, -> { where(status: 'pending') }
  scope :resolved, -> { where(status: 'resolved') }
  scope :escalated, -> { where(status: 'escalated') }
end
