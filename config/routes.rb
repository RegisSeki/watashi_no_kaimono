Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  namespace :api do
    namespace :v1 do
      resources :categories, only: [:index, :create, :update, :destroy]
      resources :subcategories, only: [:index, :create, :update, :destroy]
      resources :products, only: [:index, :create, :update, :destroy]
      resources :stats, only: [:index]
      resources :users, only: [:index, :create, :destroy]

      post 'authenticate', to: 'authentication#create'
      post 'refresh_token', to: 'authentication#refresh'
  	end
  end
end
