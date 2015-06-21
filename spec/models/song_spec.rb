require 'rails_helper'

RSpec.describe Song, type: :model do
  describe ".url_scraper" do
    let(:song){FactoryGirl.create(:song)}
    it "updates song url" do
      expect(song.url).to include("http://genius.com")
    end
  end
  describe ".lyric_scraper" do
    xit "returns lyrics using Nokogiri" do

    end
  end

end
