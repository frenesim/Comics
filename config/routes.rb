Rails.application.routes.draw do

  root to: 'comic_collections#index'

  resources :comic_collections, only: :index

end
