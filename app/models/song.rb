class Song < ActiveRecord::Base
  has_many :artist_songs
  has_many :artists, :through => :artist_songs

  # def initialize(artist)
  #   @artist = artist
  # end
  #
  # def get_artist!
  #   songs = RapGenius.search(@artist)
  # end
end
