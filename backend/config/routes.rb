Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
  namespace :api do
    namespace :v1 do
      resources :customers
      resources :products, only: %i[index show]
      resources :orders, only: %i[show create]
      resources :payments, only: %i[show create]
    end
  end
end
