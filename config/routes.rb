Rails.application.routes.draw do
  devise_for :users
  root to: "home#index"

  get 'home/driver', to: "home#driver"
  get 'home/rider', to: "home#rider"

  scope defaults: {format: :json}, constraints: { format: /(json)/ } do
    namespace :api do
      namespace :drivers do
        resources :trips
      end

      namespace :riders do
        resources :trips, only: [] do
          collection do
            match :search, via: [:get, :post]
          end

        end
      end
    end
  end
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
