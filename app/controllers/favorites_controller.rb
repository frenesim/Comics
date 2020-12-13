class FavoritesController < ApplicationController

  def toggle
    if favorite = Favorite.find_by(comic_id: params["comic_id"], user_session: cookies[:current_user])
      favorite.destroy
    else
      Favorite.create comic_id: params["comic_id"], user_session: cookies[:current_user]
    end
    render partial: "comic_collections/comic_cover", locals: {comic: Comic.new(params["comic_id"])}
  end

end
