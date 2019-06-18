class AddTrackRefToLyric < ActiveRecord::Migration[5.2]
  def change
    add_reference :lyrics, :track, foreign_key: true
  end
end
