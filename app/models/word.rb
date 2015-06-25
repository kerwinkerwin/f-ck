class Word < ActiveRecord::Base
  has_many :song_words
  has_many :songs, :through => :song_words, dependent: :destroy
  has_many :artists, :through => :songs
end
