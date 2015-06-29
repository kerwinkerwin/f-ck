class ArtistsController < ApplicationController
  def index
    @data = Artist.generate_all
    @artists = Artist.all.pluck(:name)
  end

  def show
    @data = Artist.generate(params[:artist])
  end
end
