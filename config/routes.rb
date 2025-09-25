Rails.application.routes.draw do
  mount Rswag::Ui::Engine => "/api-doc"
  mount Rswag::Api::Engine => "/api-doc"
  root "home#index"

  namespace :api do
    namespace :v1 do
      resources :rates, only: [ :index ] do
        collection do
          get :province
          get :city
          get :district
          get :sub_district
        end
      end
    end
  end
end
