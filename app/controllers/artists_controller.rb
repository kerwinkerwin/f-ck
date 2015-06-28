class ArtistsController < ApplicationController
  def index
    @data = Artist.generate_data
  end

  def show
    Artist
  end
end
