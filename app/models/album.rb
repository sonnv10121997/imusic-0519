class Album < ApplicationRecord
  ALBUM_PARAMS = [:name, :year, :artist_id, :cover, category_ids: []].freeze

  ratyrate_rateable Settings.album.rateable

  belongs_to :artist

  has_many :category_albums, dependent: :destroy
  has_many :favourites, as: :favourable
  has_many :categories, through: :category_albums
  has_many :tracks
  has_one_attached :cover

  delegate :name, to: :artist, prefix: true

  validates :name, length: {maximum: Settings.album.name.max_length},
    presence: true
  validates :year, presence: true, numericality: {only_integer: true,
    greater_than: Settings.album.year.minimum}
  validates :artist, presence: true
  validates :category_albums, presence: true
  validates :cover, attached: true, content_type: Settings.album.cover.file_type,
    size: {less_than: Settings.album.cover.max_size.megabytes}

  scope :latest_with_limit, ->(limit) {order(created_at: :desc).limit limit}
end
