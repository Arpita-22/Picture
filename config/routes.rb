Rails.application.routes.draw do
  resources :image_tags
  resources :tags
  resources :images
  resources :users

  resources :users, only: [:new, :create, :index]

  resources :login, only: [:new, :create]
  delete "logout", to: "login#destroy", as: "log_out" 
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
