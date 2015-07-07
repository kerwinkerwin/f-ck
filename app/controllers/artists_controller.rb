class ArtistsController < ApplicationController
  def index
    @artists = Artist.all
  end

  def show
    @artist = Artist.find(params[:id])
    @object = generate_words(@artist.name)
  end

  def data
    respond_to do |format|
      format.json{
        render :json => generate_words(params[:artist])
      }
    end
  end

  private

  def generate_words(name)
    Artist.generate(name)
  end
end
