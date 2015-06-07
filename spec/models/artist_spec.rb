require 'rails_helper'

RSpec.describe Artist, type: :model do
  describe "#get_songs!" do

    it "returns an array of songs" do
      Artist.get_songs!('Migos')
      expect(Artist.get_songs!).to be_type_of(Array)
    end
  end
end
