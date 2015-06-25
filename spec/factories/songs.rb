FactoryGirl.define do
  factory :song do
    name "Versace"
    rg_id 176872
    # after(:build) { |song| song.class.skip_callback(:create, :after, :url_scraper, :lyric_scraper, :build_lyrics) }
  end
end
