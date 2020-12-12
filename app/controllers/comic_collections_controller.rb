class ComicCollectionsController < ApplicationController

  def index
    comic_colection = ComicCollection.new
    comic_colection.limit = 2
    @comics = comic_colection.comics
  end

end