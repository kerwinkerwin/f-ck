class Song < ActiveRecord::Base
  has_many :artist_songs
  has_many :artists, :through => :artist_songs
  after_create :lyric_scraper


end

private


def lyric_scraper
  ##Takes song.id 
  ##and returns url
  ##uses Nokogiri to scrape and return lyrics along with some
  ##gsub
end

def build_lyrics
  ##Take the lyrics from lyric_scraper
  #Do some gsub to turn lyrics into array of lyrics
  # Save lyrics to db
end

def sort_lyrics
