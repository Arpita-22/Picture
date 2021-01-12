Rails.application.routes.draw do
  
  resources :image_tags
  resources :tags
  resources :images do
    collection do
  get '/images/search', to: "images#search"
  end
 end

  resources :users

  resources :users, only: [:new, :create, :index]
  resources :images, only: [:new,:create, :index, :search, :show]
  resources :login, only: [:new, :create]
  delete "logout", to: "login#destroy", as: "log_out"
  
  # post '/images/search', to: "images#search"
  
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
