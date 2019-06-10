class TrackLyric < ApplicationRecord
  belongs_to :lyric
  belongs_to :track
end
