class Booking < ApplicationRecord
  after_create :create_chatroom

  belongs_to :skill
  belongs_to :user
  has_many :reviews, dependent: :destroy
  has_one :chatroom, dependent: :destroy

  validates :token_cost, :session_format, :start_date, :end_date, :content, :status, presence: true
  validates :status, inclusion: { in: %w[pending confirmed rejected] }

  private

  def create_chatroom
    Chatroom.create(booking: self)
  end
end
