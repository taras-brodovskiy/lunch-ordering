Rails.application.routes.draw do
  get 'sessions/new'
  root 'static_pages#home'
  get '/signin',  to: 'sessions#new'
  post '/signin', to: 'sessions#create'
  delete '/signout', to: 'sessions#destroy'
  get '/signup',  to: 'users#new'  
  resources :users,  only: [:new, :create, :edit, :update, :index]
  resources :items,  only: [:create, :index]
  resources :menus,  only: [:new, :create, :edit, :update, :show]
  resources :fillings, only: [:create, :update]
  resources :orders, only: [:create, :index]
  get '/orders/to-current-order/:item_name', to: 'orders#add_to_current_order'
  get '/orders/clear-order', to: 'orders#clear_order'
end
