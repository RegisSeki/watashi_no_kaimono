Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  namespace :api do
    namespace :v1 do
      resources :categories, only: [:index, :create, :destroy]
      resources :products, only: [:index, :create, :destroy]
      resources :stats, only: [:index]
      resources :users, only: [:index, :create, :destroy]

      post 'authenticate', to: 'authentication#create'
  	end
  end
end
