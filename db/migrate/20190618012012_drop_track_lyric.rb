class DropTrackLyric < ActiveRecord::Migration[5.2]
  def change
    drop_table :track_lyrics
  end
end
