Rails.application.routes.draw do
  root "static#index"
  get "artworks/index"
  get "sessions/create"
  get "sessions/destroy"
  post "/signup", to: "users#create"
  post "/login", to: "sessions#create"
  delete "/logout", to: "sessions#destroy"
  get "/me", to: "users#me"
  get "/artworks", to: 'artworks#index'

  scope :user_gallery do
    post "add_artwork/:artwork_id", to: "user_galleries#add_artwork"

    get "/", to: "user_galleries#show"
  end

  scope :quiz do
    get "question", to: "quizzes#generate_question"
    post "submit_answer", to: "quizzes#submit_answer"
  end
end
