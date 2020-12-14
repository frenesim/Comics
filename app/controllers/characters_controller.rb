class CharactersController < ApplicationController

  def search
    if params["character_name"] != ""
      character = Character.new params["character_name"]
      redirect_to comic_collections_path(character: character.id, character_name: params["character_name"])
    else
      redirect_to comic_collections_path
    end
  end
end