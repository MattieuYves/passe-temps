class Chatroom < ApplicationRecord
  belongs_to :booking

  has_many :messages, dependent: :destroy
  validates :booking_id, uniqueness: true

  def has_unread_messages?
    messages.where(read: false).exists?
  end

  def unread_messages_count_for(user)
    messages.where(read: false).where.not(user: user).count
  end
end
