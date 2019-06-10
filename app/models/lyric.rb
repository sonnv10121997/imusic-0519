class Lyric < ApplicationRecord
  belongs_to :user

  has_many :track_lyrics
  has_many :tracks, through: :track_lyrics
end
