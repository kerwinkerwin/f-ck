require 'rapgenius'
require 'nokogiri'
require 'open-uri'


class Artist < ActiveRecord::Base
  has_many :artist_songs
  has_many :songs, :through => :artist_songs, dependent: :destroy
  has_many :words, :through => :songs
  before_create :downcase, :exists?
  after_create :search


  # def self.exists?(artist)
  #   if Artist.find_by(name:artist) != true
  #     current_artist = Artist.create(name:artist)
  #   else
  #     current_artist = Artist.find_by(name:artist)
  #   end
  # end
  def update_artist(artist)
    search(artist)
  end

  private
  def get_bio_url!
    bio_url = []
    @songs.each do |song|
      bio_url << song.artist.url if self.name == song.artist.name.downcase
    end
    @songs
    get_bio(bio_url[0])
  end

  def get_bio(bio_url)
    doc = Nokogiri::HTML(open("#{bio_url}"))
    bio_s = doc.css("div.body_text")
    bio = bio_s[0].children[1].children.map{|child|child.text}.join("")
    self.update(bio: bio)
  end

  def downcase
    self.name = self.name.downcase
  end

  def exists?
    return false if Artist.find_by(name:self.name) != nil
  end

  def search
    puts "search"
    @songs = RapGenius.search(self.name)
    puts self.name
    get_bio_url!
    create_song
  end

  def create_song
    @songs.each do |song|
      if Song.find_by(rg_id:song.id) == nil
        self.songs.create(name:song.title, rg_id:song.id)
      end
    end
  end

  def self.generate(artist)
    artist= Artist.find_by(name:artist)
  # Artist.find_by(name:artist).map do |artist|
      {artist:artist.name, words:sort_words(artist.words)}
    # end
  end

  def self.generate_all
    Artist.all.map do |artist|
      {artist:artist.name, words:sort_words(artist.words)}
    end
  end

  def self.sort_words(words)
    word_count = words.map{|word|word.name}
    uniq_words = word_count.uniq
    word_counts = uniq_words.map{|word| [word, word_count.count(word)]}.to_h
    word_counts.sort_by{|k, v| v}.reverse.to_h
  end
end
