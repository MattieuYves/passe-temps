class Booking < ApplicationRecord
  after_create :create_chatroom
  has_one :chatroom, dependent: :destroy

  belongs_to :skill
  belongs_to :user
  # belongs_to :other_user, class_name: 'User'
  has_many :reviews, dependent: :destroy

  validates :token_cost, :session_format, :start_date, :end_date, :content, :status, presence: true
  validates :status, inclusion: { in: %w[pending confirmed rejected] }

  def other_user(current_user)
    return user unless user == current_user
    skill.user
  end

  private

  def create_chatroom
    Chatroom.create(booking: self)
  end

  def past?
    end_date < Time.zone.now
  end


end
