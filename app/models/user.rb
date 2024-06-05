class User < ApplicationRecord
  has_many :skills
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
  :recoverable, :rememberable, :validatable

  has_many :reviews, dependent: :destroy #celles que tu as postées
  has_many :skills, dependent: :destroy

  has_many :bookings_as_teacher, through: :skills, source: :bookings
  has_many :bookings, dependent: :destroy

  has_many :reviews_as_a_teacher, through: :bookings, source: :reviews #celles qu'on t'as données
  has_many :messages, dependent: :destroy

  scope :skilled_users, -> { joins(:skills).distinct }

end
