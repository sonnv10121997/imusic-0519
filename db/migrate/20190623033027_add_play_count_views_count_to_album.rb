class AddPlayCountViewsCountToAlbum < ActiveRecord::Migration[5.2]
  def change
    add_column :albums, :play_count, :integer, default: 0
    add_column :albums, :views_count, :integer, default: 0
  end
end
