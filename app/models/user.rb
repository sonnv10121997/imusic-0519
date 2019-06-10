class User < ApplicationRecord
  devise :database_authenticatable, :registerable, :recoverable, :rememberable,
    :validatable

  has_many :lyrics
  has_many :comments
  has_many :favourites
end
