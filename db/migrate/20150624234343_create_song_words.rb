class CreateSongWords < ActiveRecord::Migration
  def change
    create_table :song_words do |t|
      t.belongs_to :song, index:true
      t.belongs_to :word, index:true
      t.timestamps null: false
    end
  end
end
