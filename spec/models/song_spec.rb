require 'rails_helper'

RSpec.describe Song, type: :model do
  describe ".url_scraper" do

    let(:song){FactoryGirl.create(:song)}
    it "updates song url" do
      song.send(:url_scraper)
      p song.url
      expect(song.url).to include("http://genius.com")
    end
  end
end
