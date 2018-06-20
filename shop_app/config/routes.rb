Rails.application.routes.draw do

  get 'password_resets/new'

  get 'password_resets/show'

  get 'thanks_for_order/index'

  get 'terms_conditions/index'

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root 'shop#index'

  get '/login' => 'sessions#new' 
  post '/login' => 'sessions#create'
  get '/logout' => 'sessions#destroy' 
  get 'sign_up' => 'users#new'
  post 'sign_up' => 'users#create'
  get '/search' => 'shop#search'
  post '/search' => 'shop#search'
  get '/thanks_for_order' => 'thanks_for_order#index'

  resources :shop, only: [:index, :create, :show]
  resources :sessions, only: [:create, :destroy]
  resources :users
  resources :products do 
    resources :comments_product
  end
  resources :account_activations, only: :edit
  resources :category
  resources :password_resets, only: [:new, :create, :edit, :update]
  resources :products, only: [:show, :update]
  resources :carts, except: %i(new edit)
  resources :checkout

  resources :transactions, controller: :checkout
  resources :terms_conditions, only: [:index]
  resources :articles do 
    resources :comments
  end
end

