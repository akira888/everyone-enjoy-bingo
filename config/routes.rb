Rails.application.routes.draw do
  # Defines the root path route ("/")
  root "games#index"

  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html
  resources :games, param: :owners_url_hash do
    resource :owner, except: %i[edit, update, destroy]
    member do
      patch :waiting
      patch :start
      patch :finish
    end
  end

  get "entry/:game_players_url_hash", to: 'players#new', as: 'players_entry'

  resources :players, param: :url_hash, only: %i[show create]
end
