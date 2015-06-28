class ArtistsController < ApplicationController
  def index
    @data = Artist.generate_data
  end

  def show
  end

  private



end
