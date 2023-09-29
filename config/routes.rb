Rails.application.routes.draw do
  # Defines the root path route ("/")
  root "games#index"

  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html
  resources :games, param: :owners_url_hash do
    resource :owner, only: %i[show new create]
    member do
      patch :waiting
      patch :start
      patch :play
      patch :finish
    end
  end

  get "entry/:game_players_url_hash", to: 'players#new', as: 'players_entry'

  resources :players, param: :url_hash, only: %i[show new create] do
    resource :card, only: %i[show update] do
      member do
        get :playing, to: 'cards#edit'
      end
    end
  end
end
