class Skill < ApplicationRecord
  has_many :sessions, dependent: :destroy
  belongs_to :user
  has_one_attached :photo

  validates :name, :goal, :experience_year, :category, presence: :true, allow_blank: false
  validates :experience_year, numericality: { only_integer: true }

  CATEGORY = %w[art_artisanat musique lecture écriture cuisine_pâtisserie jardinage photographie randonnée_camping sports jeux_de_société puzzles modélisme danse pêche informatique méditation_yoga observation_oiseaux collection cinéma voyages bricolage tricot_couture poterie_céramique plongée_surf escalade astronomie équitation aéromodélisme calligraphie origami magie cosplay jeux_vidéo dégustation_vins brassage_bières histoire_archéologie langues_étrangères aquariophilie volontariat scrapbooking_digital drone_pilotage]

  validates :category, inclusion: CATEGORY, presence: true


end
