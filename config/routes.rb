Rails.application.routes.draw do
  get 'pages/about'
  get 'pages/contact'
  devise_for :admins
  get 'home/index'
  root 'home#index'

  get 'admin_dashboard/show'

  devise_for :users
  resources :users
  resources :products
  resources :categories
  resources :orders

  get '/about', to: 'pages#about', as: 'about'
  get '/contact', to: 'pages#contact', as: 'contact'

  resources :about_contents, only: [:edit, :update]
  resources :contact_contents, only: [:edit, :update]

  get '/products_page', to: 'products#products_page', as: 'products_page'
  get '/categories_page', to: 'categories#categories_page', as: 'categories_page'

  get '/404', to: 'errors#not_found'

  get '/cart', to: 'carts#show', as: 'cart'
  get '/all_orders', to: 'orders#all_orders', as: 'all_orders'

  post 'add/:id', to: 'carts#add_to_cart', as: 'cart_add'
  patch 'update/:id', to: 'carts#update_quantity', as: 'cart_update'
  get 'remove/:id', to: 'carts#remove_from_cart', as: 'cart_remove'

  resources :orders, only: [:new, :create, :show]

  patch '/orders/:id/update_status', to: 'orders#update_status', as: 'update_order_status'

  resources :taxes, only: [:edit, :update]

  match '*unmatched', to: 'errors#not_found', via: :all
end
