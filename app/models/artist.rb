class Artist < ApplicationRecord
  ARTIST_PARAMS = %i(name avatar description dob country).freeze

  has_many :albums
  has_many :tracks
  has_one_attached :avatar

  validates :name, length: {maximum: Settings.artist.name.max_length},
    presence: true
  validates :country, length: {maximum: Settings.artist.country.max_length},
    presence: true
  validates :dob, presence: true
  validates :avatar, attached: true, content_type: Settings.artist.avatar.file_type,
    size: {less_than: Settings.artist.avatar.max_size.megabytes}
end
