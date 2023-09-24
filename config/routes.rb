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
end
