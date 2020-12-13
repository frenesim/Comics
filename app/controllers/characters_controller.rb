class CharactersController < ApplicationController

  def search
    character = Character.new params["character_name"]
    redirect_to comic_collections_path(characters: character.id)
  end
end