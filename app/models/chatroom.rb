class Chatroom < ApplicationRecord
  belongs_to :booking

  has_many :messages, dependent: :destroy
  # validates :booking_id, uniqueness: true
  # validates :name, presence: true
end
