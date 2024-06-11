class Skill < ApplicationRecord
  has_many :bookings, dependent: :destroy
  belongs_to :user
  has_one_attached :photo

  CATEGORY = %w[art/artisanat musique lecture écriture cuisine/pâtisserie jardinage photographie randonnée/camping sports jeux/de/société puzzles modélisme danse pêche informatique méditation/yoga observation/oiseaux collection cinéma voyages bricolage tricot/couture poterie/céramique plongée/surf escalade astronomie équitation aéromodélisme calligraphie origami magie cosplay jeux/vidéo dégustation/vins brassage/bières histoire/archéologie langues/étrangères aquariophilie volontariat scrapbooking/digital drone/pilotage]

  validates :name, :goal, :experience_year, :category, presence: :true, allow_blank: false
  validates :experience_year, numericality: { only_integer: true }
  # validates :category, inclusion: CATEGORY, presence: true


  include PgSearch::Model
  pg_search_scope :search_by_skill,
    against: [ :skill ],
    using: {
      tsearch: { prefix: true }
    }

end
