class Track < ApplicationRecord
  TRACK_PARAMS = %i(title year cover data artist_id album_id).freeze

  ratyrate_rateable Settings.track.rateable

  belongs_to :artist
  belongs_to :album

  has_many :favourites, as: :favourable, dependent: :destroy
  has_many :comments, dependent: :destroy
  has_many :lyrics, dependent: :destroy
  has_one :approved_lyric, ->{where approved: true}, dependent: :destroy,
    class_name: Lyric.name, foreign_key: :track_id
  has_one_attached :cover
  has_one_attached :data

  delegate :name, to: :artist, prefix: true
  delegate :name, to: :album, prefix: true

  validates :title, length: {maximum: Settings.track.title.max_length},
    presence: true
  validates :year, presence: true, numericality: {only_integer: true,
    greater_than: Settings.track.year.minimum}
  validates :artist, presence: true
  validates :album, presence: true
  validates :cover, attached: true, content_type: Settings.track.cover.file_type,
    size: {less_than: Settings.track.cover.max_size.megabytes}
  validates :data, attached: true, content_type: Settings.track.data.file_type,
    size: {less_than: Settings.track.data.max_size.megabytes}

  scope :latest, ->{order created_at: :desc}
  scope :top, ->{order play_count: :desc}
end
