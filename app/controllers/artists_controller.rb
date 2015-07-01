class ArtistsController < ApplicationController
  def index
    @artists = Artist.all
  end

  def show
    @artist = Artist.find(params[:id])
    p @artist.name
    @object = Artist.generate(@artist.name)
    render
  end
end
