class Lyric < ApplicationRecord
  LYRIC_PARAMS = %i(content approved user_id track_id).freeze

  belongs_to :user
  belongs_to :track

  delegate :name, to: :user, prefix: true
  delegate :title, to: :track, prefix: true

  validates_presence_of :content, :user, :track
  validates_uniqueness_of :approved, scope: :track_id,
    conditions: ->{where approved: true}
end
