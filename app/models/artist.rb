require 'rapgenius'
require 'open-uri'


class Artist < ActiveRecord::Base
  has_many :artist_songs
  has_many :songs, :through => :artist_songs, dependent: :destroy
  has_many :words, :through => :songs
  before_create :downcase
  after_create :search


  # def self.exists?(artist)
  #   if Artist.find_by(name:artist) != true
  #     current_artist = Artist.create(name:artist)
  #   else
  #     current_artist = Artist.find_by(name:artist)
  #   end
  # end
  def update_artist(artist)
    search(artist)
  end

  private

  def downcase
    self.name = self.name.downcase
  end

  def search
    @songs = RapGenius.search(self.name)
    create_song
  end

  def create_song
    @songs.each do |song|
      if Song.find_by(rg_id:song.id) == nil
        self.songs.create(name:song.title, rg_id:song.id)
      end
    end
  end

  def self.generate_data
    data = []
    Artist.all.each do |artist|
      data << {artist:artist.name, words:sort_words(artist.words)}
    end
    return data
  end

  def self.sort_words(words)
    word_count = words.map{|word|word.name}
    uniq_words = word_count.uniq
    word_counts = uniq_words.map{|word| [word, word_count.count(word)]}.to_h
    word_counts.sort_by{|k, v| v}.reverse.to_h
  end
end
