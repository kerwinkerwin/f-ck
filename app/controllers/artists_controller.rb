class ArtistsController < ApplicationController
  def index
    @artist = Artist.first
    # @words = @artist.words
    @words = sort_words(@artist.words)
  end
  def show

  end

  private

  def sort_words(words)
    word_count = words.map{|word|word.name}
    uniq_words = word_count.uniq
    word_counts = uniq_words.map{|word| [word, word_count.count(word)]}.to_h
    word_counts.sort_by{|k, v| v}.reverse.to_h
  end
end
