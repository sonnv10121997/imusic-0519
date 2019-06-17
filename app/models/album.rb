class Album < ApplicationRecord
  ALBUM_PARAMS = [:name, :year, :artist_id, category_ids: []].freeze

  belongs_to :artist

  has_many :category_albums, dependent: :destroy
  has_many :album_tracks
  has_many :favourites, as: :favourable
  has_many :categories, through: :category_albums
  has_many :tracks, through: :album_tracks

  delegate :name, to: :artist, prefix: true

  validates :name, length: {maximum: Settings.album.name.max_length},
    presence: true
  validates :year, presence: true, numericality: {only_integer: true,
    greater_than: Settings.album.year.minimum}
  validates :artist, presence: true
  validates :category_albums, presence: true
end
