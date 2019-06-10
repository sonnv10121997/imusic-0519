class Category < ApplicationRecord
  has_many :category_albums
  has_many :albums, through: :category_albums
end
