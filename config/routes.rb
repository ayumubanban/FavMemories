Rails.application.routes.draw do

  # * likes
  # post "likes/:post_id/create" => "likes#create"
  post "posts/:post_id/likes" => "likes#create"
  # post "likes/:post_id/destroy" => "likes#destroy"
  delete "posts/:post_id/likes" => "likes#destroy"

  # * users
  get "login" => "users#login_form"
  post "login" => "users#login"
  post "logout" => "users#logout"
  get 'users/index' => "users#index"
  get "users/:id" => "users#show"
  get "signup" => "users#new"
  post "users/create" => "users#create"
  get "users/:id/edit" => "users#edit"
  post "users/:id/update" => "users#update"
  # * users / likes
  get "users/:id/likes" => "users#likes"
  # * users / relationships
  post "users/:user_id/relationships/create" => "relationships#create"
  post "users/:user_id/relationships/destroy" => "relationships#destroy"
  get "users/:id/follows" => "users#follows"
  get "users/:id/followers" => "users#followers"

  # * posts
  get 'posts/index' => "posts#index"
  get "posts/new" => "posts#new"
  post "posts/create" => "posts#create"
  get "posts/:id" => "posts#show"
  get "posts/:id/edit" => "posts#edit"
  post "posts/:id/update" => "posts#update"
  post "posts/:id/destroy" => "posts#destroy"
  # * posts / comments
  post "posts/:post_id/comments/create" => "comments#create"
  post "posts/:post_id/comments/:id/destroy" => "comments#destroy"

  # * home
  get '/' => "home#top"
  get "about" => "home#about"

end
