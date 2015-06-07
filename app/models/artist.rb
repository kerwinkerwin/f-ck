require 'rapgenius'

class Artist < ActiveRecord::Base
  has_many :artist_songs
  has_many :songs, :through => :artist_songs, dependent: :destroy

  # RapGenius::Client.access_token = 'Q6RjOeRCD8S3720jq5frKI-YGMDTX0YYHniz5B7RYpQUsfr3uNDdNDlI0_6gq61k'

  def self.get_songs!(artist)
    songs =RapGenius.search(artist)
    artist_songs=[]
    songs.each do |song|
      artist_songs << RapGenius::Song.find(song.id)
    end
     artist_songs.first.each do |key,value|
       puts "*************************"
       puts "#{key},#{value}"
       puts "*************************"
     end
  end
end
