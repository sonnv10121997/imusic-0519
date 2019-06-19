class Category < ApplicationRecord
  CATEGORY_PARAMS = %i(name cover).freeze

  has_many :category_albums
  has_many :albums, through: :category_albums
  has_one_attached :cover

  validates :name, presence: true, uniqueness: {case_sensitive: false},
    length: {maximum: Settings.category.name.max_length}
  validates :cover, attached: true, content_type: Settings.category.cover.file_type,
    size: {less_than: Settings.category.cover.max_size.megabytes}
end
