Rails.application.routes.draw do
  resources :orders
  resources :line_items do
    post 'decrement', on: :member
  end
  resources :carts
  root 'store#index', as: 'store_index' # define the store/index as root view for our app

  resources :products
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
