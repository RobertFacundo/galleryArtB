Rails.application.routes.draw do
  get "artworks/index"
  get "sessions/create"
  get "sessions/destroy"
  post "/signup", to: "users#create"
  post "/login", to: "sessions#create"
  delete "/logout", to: "sessions#destroy"
  get "/me", to: "users#me"
  get "/artworks", to: 'artworks#index'
end
