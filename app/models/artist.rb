require 'rapgenius'
require 'open-uri'


class Artist < ActiveRecord::Base
  has_many :artist_songs
  has_many :songs, :through => :artist_songs, dependent: :destroy
  has_many :words, :through => :songs
  # has_many :words, through: :songs


  # def self.exists?(artist)
  #   if Artist.find_by(name:artist) != true
  #     current_artist = Artist.create(name:artist)
  #   else
  #     current_artist = Artist.find_by(name:artist)
  #   end
  # end
  def search
    @songs = RapGenius.search(self.name)
    create_song
  end

  private

  def create_song
    @songs.each do |song|
      self.songs.create(name:song.title, rg_id:song.id)
    end
  end

  def update_artist
    ##checks for new songs against the db using the song.id
  end

end
