require 'rapgenius'
require 'open-uri'


class Artist < ActiveRecord::Base
  has_many :artist_songs
  has_many :songs, :through => :artist_songs, dependent: :destroy

  after_create :search_rap_genius


  # def self.exists?(artist)
  #   if Artist.find_by(name:artist) != true
  #     current_artist = Artist.create(name:artist)
  #   else
  #     current_artist = Artist.find_by(name:artist)
  #   end
  # end
  private
  def search_rap_genius
    RapGenius::Client.access_token = 'xtN_egmb5AUedPvEWYlOR78Vj61nOut2x4dNOESPuyabOu09-ZSuqSbTB15xMaUB'
    songs = RapGenius.search(self.name)
    songs.each do |song|
      ##if rg_id already exists then don't create a song
      self.songs.create(name:song.title, rg_id:song.id) if song.title !=nil && song.id !=nil
      # artist_songs[:song] << RapGenius::Song.find(song.id)
    end
  end

  def self.create_song!
    # self.create_song!
    lyrics_url=@artist_songs[:song].first.document["response"]["song"]["bop_url"][/(?<=(\/http))(.*)(?=\?)/].gsub(/%3A/,"http:").gsub(/(%2F)/,"/")
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
