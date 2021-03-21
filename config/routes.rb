Rails.application.routes.draw do
  devise_for :users
  root "application#index"
  resources :groups do
    resources :member
  end
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
