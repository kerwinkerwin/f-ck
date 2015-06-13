require 'rails_helper'

RSpec.describe Artist, type: :model do
  describe "#exists?" do
    before do
      # @artist = Artist.create(name:"Kendrick Lamar")
      Artist.exists?("ASAP")
    end

    context "when passing in an existing Artist" do
      it "it returns true" do
        # expect(Artist.exists?("Kendrick Lamar")).to equal(true)
      end
    end

  end
  after do
    Artist.destroy_all
    Song.destroy_all
  end
end
