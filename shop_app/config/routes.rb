Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root 'shop#index'

  get '/login' => 'sessions#new' 
  post '/login' => 'sessions#create'
  get '/logout' => 'sessions#destroy' 
  get 'sign_up' => 'users#new'
  post 'sign_up' => 'users#create'
  resources :sessions, only: [:create, :destroy]
  resources :users
  resources :account_activations, only: :edit
end
