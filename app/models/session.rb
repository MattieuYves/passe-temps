class Session < ApplicationRecord
  belongs_to :skill
  belongs_to :user
  has_one :review

  validates :duration, :token_cost, :session_format, :start_date, :end_date, :content, :status, presence: true
  validates :status, inclusion: { in: %w[pending confirmed rejected] }


end
