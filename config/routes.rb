Rails.application.routes.draw do

  get 'favorites/toggle'
  root to: 'comic_collections#index'

  resources :comic_collections, only: :index

  get 'search_character', to: 'characters#search'

end
