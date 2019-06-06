class Album < ApplicationRecord
  belongs_to :artist

  has_many :category_albums
  has_many :album_tracks
  has_many :favourites, as: :favourable
  has_many :categories, through: :category_albums
  has_many :tracks, through: :album_tracks
end
