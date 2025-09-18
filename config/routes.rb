Rails.application.routes.draw do
  root "home#index"

  namespace :api do
    namespace :v1 do
      resources :rates, only: [:index]
      resources :trackings, only: [:show]
    end
  end
end