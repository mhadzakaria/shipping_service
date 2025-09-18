Rails.application.routes.draw do
  root "home#index"

  resources :rates, only: [:index]
  resources :trackings, only: [:show]
end