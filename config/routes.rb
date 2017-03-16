Rails.application.routes.draw do

  root "static_pages#home"
  get "/help", to: "static_pages#help"
  get "/about", to: "static_pages#about"
  get "/contact", to: "static_pages#contact"
  get "/signup", to: "users#new"
  get "/login", to: "sessions#new"
  post "/login", to: "sessions#create"
  delete "/logout", to: "sessions#destroy"

  resources :users
  resources :cartitems
  resources :orders
  resources :orderitems, only: :update
  resources :search, only: :index
  resources :subcategories, only: :show
  resources :products, only: :show
  resources :rates, only: [:create, :update]
  resources :comments
  resources :suggests

  namespace :admin do
    root "admin#index"
    resources :users, except: [:show, :new, :create]
    resources :categories
    resources :subcategories, except: [:show]
    resources :products
    resources :orders
    resources :orderitems
    resources :suggests
    resources :statistics, only: :index
  end
end
