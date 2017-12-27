Rails.application.routes.draw do
  resources :line_items
  resources :carts
  root 'store#index', as: 'store_index' # define the store/index as root view for our app

  resources :products
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
