class CreateArtists < ActiveRecord::Migration[5.2]
  def change
    create_table :artists do |t|
      t.string :name
      t.text :description
      t.date :dob
      t.string :country

      t.timestamps
    end
  end
end
