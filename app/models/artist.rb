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
    puts artist_songs.length
    song = artist_songs.first.lines.map{|line|line.lyric}
    song.map!{|line| line if [""," [?]",nil,["Intro"],["Verse 1"],["Verse 2"],"[]"].include?(line)!=true}
    string_song = song.join(",")
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
    sorted.each{|key,value| puts "#{key},#{value}"}
  end
end
