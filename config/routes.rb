Rails.application.routes.draw do
  devise_for :users
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
  resources :orders
  resources :users
  get 'orders_params/new/:origin_order_id', to: 'orders#new_params', as: :new_order_params
  root "orders#index"
end
