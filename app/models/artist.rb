class Artist < ApplicationRecord
  ARTIST_PARAMS = %i(name description dob country).freeze

  has_many :albums
  has_many :tracks

  validates :name, length: {maximum: Settings.artist.name.max_length},
    presence: true
  validates :country, length: {maximum: Settings.artist.country.max_length},
    presence: true
  validates :dob, presence: true
end
