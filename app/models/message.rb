class Message < ApplicationRecord
  belongs_to :user
  belongs_to :chatroom

  validates :content, presence: true, allow_blank: false

  def sender?(a_user)
    user.id == a_user.id
  end

end

