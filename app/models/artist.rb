require 'rapgenius'

class Artist < ActiveRecord::Base
  has_many :artist_songs
  has_many :songs, :through => :artist_songs, dependent: :destroy
  RapGenius::Client.access_token = 'rcl2gtYCJitehsC-14ylK2hqCtNy6PpmStbWKGpWpp_DrNRi6_-AOVYC4L9oSkRa'

  def self.exists?(artist)
    if Artist.find_by(name:artist) != true
      current_artist = Artist.create(name:artist)
    else
      current_artist = Artist.find_by(name:artist)
    end
    self.get_songs!(current_artist.name)
  end

  def self.get_songs!(artist)
    puts artist
    rap_song = RapGenius::Song.find(176872)
    puts rap_song
    songs = RapGenius.search("Versace")
    puts "fuck"
    # @artist_songs={:artist=>"#{artist}", :song=>[]}
    songs.each do |song|
      # artist_songs[:song] << RapGenius::Song.find(song.id)
      rap_song = RapGenius::Song.find(song.id)
      puts rap_song.title
      # @artist.songs.create(name:)
    end
    # self.create_song!
  end
  #   song = artist_songs.first.lines.map{|line|line.lyric}
  #   song.map!{|line| line if [""," [?]",nil,["Intro"],["Verse 1"],["Verse 2"],"[]"].include?(line)!=true}
  #   string_song = song.join(",")
  #   string_song.gsub!(/\n/, " ").gsub!(/,/, " ")
  #   num_hooks = (string_song.scan(/\[Hook]/).length)-1
  #
  #
  #   hook = string_song[/(?<=\[Hook\])(.*)(?=\[Verse 1\])/]
  #   string_song.gsub!(/\[Hook]*/, " ")
  #   string_song << hook*num_hooks
  #   string_song.gsub!(/\[(.*?)\]/, " ")
  #   string_song_collection = string_song.split(" ").each do |word|
  #     word.downcase!
  #     word.gsub!(/[^0-9A-Za-z]/, '')
  #   end
  #   words = string_song_collection.uniq
  #   histogram = words.map{|word| [word.gsub(/\"/,"").to_sym, string_song_collection.count(word)]}.to_h
  #   # sorted = histogram.sort_by{|k,v| v }.reverse
  # end
  # def self.create_song!
  #   @songs.each do |song|
  #       Song.new(artist_songs.first.lines.map{|line|line.lyric}
  #   end
  # end

end
