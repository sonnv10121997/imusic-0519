class CreateTracks < ActiveRecord::Migration[5.2]
  def change
    create_table :tracks do |t|
      t.string :title
      t.integer :play_count, default: 0
      t.integer :views_count, default: 0
      t.string :year
      t.references :artist

      t.timestamps
    end
  end
end
