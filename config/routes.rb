Rails.application.routes.draw do


  # * users
  get "login" => "users#login_form"
  post "login" => "users#login"
  delete "logout" => "users#logout"
  get 'users' => "users#index"
  get "users/:id" => "users#show"
  get "signup" => "users#new"
  post "users" => "users#create"
  get "users/:id/edit" => "users#edit"
  put "users/:id" => "users#update"
  delete "users/:id" => "users#destroy"
  # * users / likes
  get "users/:id/likes" => "users#likes"
  # * users / relationships
  post "users/:user_id/relationships" => "relationships#create"
  delete "users/:user_id/relationships" => "relationships#destroy"
  get "users/:id/follows" => "users#follows"
  get "users/:id/followers" => "users#followers"
  # * oauth google&github
  get 'auth/:provider/callback', to: 'users#login_sns'
  get 'auth/failure', to: redirect('/')

  # * posts
  get 'posts' => "posts#index"
  get "posts/new" => "posts#new"
  post "posts" => "posts#create"
  get "posts/:id" => "posts#show"
  get "posts/:id/edit" => "posts#edit"
  put "posts/:id" => "posts#update"
  delete "posts/:id" => "posts#destroy"
  # * posts / likes
  post "posts/:post_id/likes" => "likes#create"
  delete "posts/:post_id/likes" => "likes#destroy"
  # * posts / comments
  post "posts/:post_id/comments" => "comments#create"
  delete "posts/:post_id/comments/:id" => "comments#destroy"

  # * home
  get '/' => "home#top"
  get "about" => "home#about"

end
