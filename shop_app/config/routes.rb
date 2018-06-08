Rails.application.routes.draw do

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root 'shop#index'

  get '/login' => 'sessions#new' 
  post '/login' => 'sessions#create'
  get '/logout' => 'sessions#destroy' 
  get 'sign_up' => 'users#new'
  post 'sign_up' => 'users#create'
  get '/search' => 'shop#search'
  post '/search' => 'shop#search'

  resources :shop, only: [:index, :create]
  resources :sessions, only: [:create, :destroy]
  resources :users
  resources :products
  resources :account_activations, only: :edit
  resources :category
  resources :password_resets, only: [:new, :create, :edit, :update]
  resources :products, only: [:show, :update]
  resources :carts, except: %i(new edit)
  resources :checkout
end
