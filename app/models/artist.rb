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
      self.songs.create(name:song.title, rg_id:song.id)
    end
  end



end
