class ComicCollectionsController < ApplicationController

  def index
    comic_colection = ComicCollection.new
    comic_colection.limit = 5
    comic_colection.offset = params["offset"] if params["offset"]
    comic_colection.characters = params["characters"] if params["characters"]
    @previous_offset = [0, comic_colection.offset.to_i - comic_colection.limit.to_i].max
    @next_offset = [comic_colection.offset.to_i + comic_colection.limit.to_i, comic_colection.total.to_i].min
    @comics = comic_colection.comics
  end

end