class Track < ApplicationRecord
  belongs_to :artist
  belongs_to :album

  has_many :track_lyrics
  has_many :lyrics, through: :track_lyrics
  has_many :favourites, as: :favourable
  has_many :comments
end
