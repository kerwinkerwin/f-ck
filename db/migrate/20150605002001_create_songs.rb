class CreateSongs < ActiveRecord::Migration
  def change
    create_table :songs do |t|
      t.string :name
      t.integer :rg_id
      t.text :lyrics
      t.timestamps null: false
    end
  end
end
