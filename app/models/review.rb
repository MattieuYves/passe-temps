class Review < ApplicationRecord
  belongs_to :booking
  belongs_to :user

  validates :comment, :title, presence: true
  validates :rating, numericality: { only_integer: true }
end
