Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
      resources :posts
      resources :users
      get '/profile', to: 'users#profile'
      post '/following/:user_id', to: 'users#following'
      post '/login', to: 'authentication#login'
      post '/follow/:id', to: 'follows#create'
      post '/unfollow/:id', to: 'follows#destroy'
    end
  end
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  # Defines the root path route ("/")
  # root "posts#index"
end
