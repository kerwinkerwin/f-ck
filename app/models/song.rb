require 'nokogiri'
require 'open-uri'

class Song < ActiveRecord::Base
  has_many :artist_songs
  has_many :artists, :through => :artist_songs
  after_create :url_scraper, :lyric_scraper, :build_lyrics

private
    def url_scraper
      song = RapGenius::Song.find(self.rg_id)

      @url = song.document["response"]["song"]["url"]
      self.update(url:@url)
      ##Takes song.id
      ##and returns url
    end

    def lyric_scraper
      ##uses Nokogiri to scrape and return lyrics along with some
      ##gsub
      doc = Nokogiri::HTML(open("#{@url}"))
      @lyrics = doc.css("div.lyrics").to_s.gsub(/<(.|\n)*?>/,"")
    end

    def hook_counter
      ###THIS METHOD IS FOR STRETCH
      # .scan(/\[(.*?)\]/)  ## Returns any text within square brackets
      # .flatten
      # ["Verse 1: Drake", "Hook: Quavo", "Verse 2: Quavo", "Hook: Quavo", "Verse 3: Takeoff", "Hook: Quavo", "Verse 4: Offset", "Hook: Quavo"]
      # c.include?(["#{d[0]}"])
      # a = above
      # b = a.uniq
      ##
      ## Problem with the hook, some songs have hooks, some have hooks by other
      ## people, will have to figure out what to do.

      #num_hooks = (string_song.scan(/\[Hook]/).length)-1
      # hook = string_song[/(?<=\[Hook\])(.*)(?=\[Verse 1\])/]
      # string_song << hook*num_hooks
      # string_song.gsub!(/\[(.*?)\]/, " ")

    end

    def build_lyrics
      string_song = @lyrics
      string_song.gsub!(/\n/, " ").gsub!(/,/, " ").gsub!(/\[(.*?)\]/, " ")
      string_song_collection = string_song.split(" ").each do |word|
        word.downcase!
        word.gsub!(/[^0-9A-Za-z]/, '')
      end
      p string_song_collections
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
