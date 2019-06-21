class Comment < ApplicationRecord
  COMMENT_PARAMS = %i(content user_id track_id).freeze

  belongs_to :user
  belongs_to :track

  delegate :cover, to: :track, prefix: true
  delegate :avatar, :name, to: :user, prefix: true

  validates :content, presence: true

  scope :latest, ->{order created_at: :desc}
end
