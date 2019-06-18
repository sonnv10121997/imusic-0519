class Track < ApplicationRecord
  TRACK_PARAMS = %i(title year artist_id album_id).freeze

  belongs_to :artist
  belongs_to :album

  has_many :favourites, as: :favourable, dependent: :destroy
  has_many :comments, dependent: :destroy
  has_many :lyrics, dependent: :destroy

  delegate :name, to: :artist, prefix: true
  delegate :name, to: :album, prefix: true

  validates :title, length: {maximum: Settings.track.title.max_length},
    presence: true
  validates :year, presence: true, numericality: {only_integer: true,
    greater_than: Settings.track.year.minimum}
  validates :artist, presence: true
  validates :album, presence: true
end
