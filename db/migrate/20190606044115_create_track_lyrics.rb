class CreateTrackLyrics < ActiveRecord::Migration[5.2]
  def change
    create_table :track_lyrics do |t|
      t.references :lyric, foreign_key: true
      t.references :track, foreign_key: true

      t.timestamps
    end
  end
end
