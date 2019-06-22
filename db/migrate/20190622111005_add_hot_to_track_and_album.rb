class AddHotToTrackAndAlbum < ActiveRecord::Migration[5.2]
  def change
    add_column :tracks, :hot, :boolean, default: false
    add_column :albums, :hot, :boolean, default: false
  end
end
