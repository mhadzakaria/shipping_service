Rails.application.routes.draw do
  root "home#index"

  namespace :api do
    namespace :v1 do
      resources :rates, only: [:index]
    end
  end
end