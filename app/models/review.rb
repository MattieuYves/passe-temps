class Review < ApplicationRecord
  belongs_to :booking
  belongs_to :user

  AUTHORIZED_RATINGS = (1..5)

  validates :title, presence: true
  validates :rating, inclusion: { in: AUTHORIZED_RATINGS }
end
