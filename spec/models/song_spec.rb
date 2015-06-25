require 'rails_helper'

RSpec.describe Song, type: :model do
  describe "after_create" do
    let(:song){FactoryGirl.create(:song)}
    it "puts out histogram" do
      p song
    end
  end
  describe ".url_scraper" do

    let(:song){FactoryGirl.create(:song)}
    xit "updates song url" do
      song.send(:url_scraper)
      p song.url
      expect(song.url).to include("http://genius.com")
    end
  end

end
