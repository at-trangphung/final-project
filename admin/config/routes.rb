Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  # resources :users, except: %i(index destroy)
  # resources :products, only: :show
  
  scope module: "admin", path: "admin" do
    resources :dashboard, only: :index
    resources :categories, except: :show
    resources :users
  end
end
