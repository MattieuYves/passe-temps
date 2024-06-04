class Chatroom < ApplicationRecord
  belongs_to :session

  has_many :messages, dependent: :destroy

  validates :name, presence: true
end
