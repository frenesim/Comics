class ComicCollectionsController < ApplicationController

  def index
    @character = params["character"]
    @character_name = params["character_name"]

    comic_colection = ComicCollection.new offset: params["offset"].to_i, characters: @character
    @previous_offset = [0, comic_colection.offset.to_i - comic_colection.limit.to_i].max
    @next_offset = [comic_colection.offset.to_i + comic_colection.limit.to_i, comic_colection.total.to_i].min
    @comics = comic_colection.comics
  end

end