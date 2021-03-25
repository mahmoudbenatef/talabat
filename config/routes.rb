Rails.application.routes.draw do
  resources :orders
  devise_for :users
  resources :groups do
    resources :members
  end
  resources :groups
  root "friends#index"
  resources :friends

  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
