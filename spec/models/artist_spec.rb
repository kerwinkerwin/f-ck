require 'rails_helper'
require 'spec_helper'

RSpec.describe Artist, type: :model do
  context "on creation" do
    # Artist.create(name:'ASAP')
    xit "calls #get_songs callback", tag: [ :db ] do
      artist = FactoryGirl.build(:artist)
      expect{ artist.save }.to change{ artist.songs.count }.from(0)
      #How to test that the after hooks work?
      # allow(artist).to receive(:get_songs!).and_return("songs")
      # expect(artist.get_songs!).to eq("songs")
    end
    let(:artist){FactoryGirl.create(:artist)}
    it "returns some info" do
        artist.search
        p artist.words
    end
  end


  context "#exists?" do
    before do
      # Artist.exists?("ASAP")
    end
    context "an existing Artist" do
      xit "it returns true" do
        # expect(Artist.exists?("Kendrick Lamar")).to equal(true)
      end
    end
    context "a new Artist" do
      xit "creates a new Artist" do
      end
    end
  end
  context "#get_songs!" do
    before do
      @artist =Artist.create(name:'ASAP')
    end
    xit "creates songs" do
      expect(@artist.songs).not_to be_empty
    end
    xit "" do
    end
  end
  after do
    Artist.destroy_all
    Song.destroy_all
  end

end
