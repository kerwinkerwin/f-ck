class Song < ActiveRecord::Base
  has_many :artist_songs
  has_many :artists, :through => :artist_songs
  after_create :url_scraper

private
    def url_scraper
      song = RapGenius::Song.find(self.rg_id)
      @url = song.document["response"]["song"]["bop_url"][/(?<=(\/http))(.*)(?=\?)/].gsub(/%3A/,"http:").gsub(/(%2F)/,"/")
      self.update(url:@url)
      ##Takes song.id
      ##and returns url
    end

    def lyric_scraper
      ##uses Nokogiri to scrape and return lyrics along with some
      ##gsub
      @url
      
    end

    def build_lyrics
      ##Take the lyrics from lyric_scraper
      #Do some gsub to turn lyrics into array of lyrics
      # Save lyrics to db
    end

    def sort_lyrics
      #sorts lyrics
    end

    def create_words
      #takes lyrics and count array and creates words
      #so can go Artist.song.words
      #possibly source association?

    end
end
