class Track < ApplicationRecord
  belongs_to :artist

  has_many :album_tracks
  has_many :track_lyrics
  has_many :albums, through: :album_tracks
  has_many :lyrics, through: :track_lyrics
  has_many :favourites, as: :favourable
  has_many :comments
end
