class DropAlbumTrack < ActiveRecord::Migration[5.2]
  def change
    drop_table :album_tracks
  end
end
