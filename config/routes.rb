Rails.application.routes.draw do

  root to: 'comic_collections#index'

  resources :comic_collections, only: :index

  get 'search_character', to: 'characters#search'

end
