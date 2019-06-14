class Category < ApplicationRecord
  has_many :category_albums
  has_many :albums, through: :category_albums

  validates :name, presence: true, uniqueness: {case_sensitive: false},
    length: {maximum: Settings.category.name.max_length}
end
