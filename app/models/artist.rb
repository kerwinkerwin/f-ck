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
  private

  def update_artist
    ##checks for new songs against the db using the song.id
  end

  def self.create_song!
    # self.create_song!
    doc = Nokogiri::HTML(open("#{lyrics_url}"))
    lyrics = doc.css("div.lyrics").to_s.gsub(/<(.|\n)*?>/,"")
    # puts @artist_songs[:song].first.lines.

    # song = lyrics.map{|line|line.lyric}
    # song.map!{|line| line if [""," [?]",nil,["Intro"],["Verse 1"],["Verse 2"],"[]"].include?(line)!=true}
    # string_song = song.join(",")
    string_song = lyrics
    string_song.gsub!(/\n/, " ").gsub!(/,/, " ")
    num_hooks = (string_song.scan(/\[Hook]/).length)-1


    hook = string_song[/(?<=\[Hook\])(.*)(?=\[Verse 1\])/]
    string_song.gsub!(/\[Hook]*/, " ")
    string_song << hook*num_hooks
    string_song.gsub!(/\[(.*?)\]/, " ")
    string_song_collection = string_song.split(" ").each do |word|
      word.downcase!
      word.gsub!(/[^0-9A-Za-z]/, '')
    end
    words = string_song_collection.uniq
    histogram = words.map{|word| [word.gsub(/\"/,"").to_sym, string_song_collection.count(word)]}.to_h
    sorted = histogram.sort_by{|k,v| v }.reverse
    puts sorted
  end
  # def self.create_song!
  #   @songs.each do |song|
  #       Song.new(artist_songs.first.lines.map{|line|line.lyric}
  #   end
  # end

end
