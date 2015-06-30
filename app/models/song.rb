require 'nokogiri'
require 'open-uri'

class Song < ActiveRecord::Base
  has_many :artist_songs
  has_many :artists, :through => :artist_songs
  has_many :song_words
  has_many :words, :through => :song_words
  after_create :url_scraper, :lyric_scraper, :build_lyrics, :sort_lyrics

private
    def url_scraper
      song = RapGenius::Song.find(self.rg_id)
      @url = song.document["response"]["song"]["url"]
      self.update(url:@url)
    end

    def lyric_scraper
      doc = Nokogiri::HTML(open("#{@url}"))
      @lyrics = doc.css("div.lyrics").to_s.gsub(/<(.|\n)*?>/,"")
    end

    def build_lyrics
      ## one/many songs are returning nil here, fuck!
      string_song = @lyrics
      string_song.gsub!(/\n/, " ").gsub!(/,/, " ")
      string_song.gsub!(/\[(.*?)\]/, " ") if string_song.include?("[")
      string_song_collection = string_song.split(" ").each do |word|
        word.downcase!
        word.gsub!(/[^0-9A-Za-z]/, '')
      end
      @lyrics = string_song_collection
    end

    def sort_lyrics
      words = @lyrics.uniq
      histogram = words.map{|word| [word.gsub(/\"/,""), @lyrics.count(word)]}.to_h
      create_words(histogram)
    end

    def create_words(histogram)
      histogram.each do |key,value|
        value.times{self.words.create(name:key)}
      end
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

end
