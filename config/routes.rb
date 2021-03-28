Rails.application.routes.draw do
  post "/addfriend", to: "order_members#create"

  devise_for :users, :controllers => { :omniauth_callbacks => "callbacks" }
  resources :orders do
    resources :orders_details
  end
  get "/notifications", to: "notifications#index"

  resources :groups do
    resources :members
  end
  root "home_pages#index"
  resources :friends

  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
