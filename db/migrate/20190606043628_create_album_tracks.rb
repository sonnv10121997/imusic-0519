class CreateAlbumTracks < ActiveRecord::Migration[5.2]
  def change
    create_table :album_tracks do |t|
      t.references :album, foreign_key: true
      t.references :track, foreign_key: true

      t.timestamps
    end
  end
end
