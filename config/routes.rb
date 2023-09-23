Rails.application.routes.draw do
  resources :games do
    resource :owner, except: %i[edit, update, destroy]
  end
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  root "games#index"
end
