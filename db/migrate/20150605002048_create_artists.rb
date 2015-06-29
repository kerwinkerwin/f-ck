class CreateArtists < ActiveRecord::Migration
  def change
    create_table :artists do |t|
      t.string :name
      t.string :img
      t.text :bio
      t.timestamps null: false
    end
  end
end
