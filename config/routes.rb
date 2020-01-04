Rails.application.routes.draw do
  get 'sessions/new'
  root 'static_pages#home'
  get '/signin',  to: 'sessions#new'
  post '/signin', to: 'sessions#create'
  delete '/signout', to: 'sessions#destroy'
  get '/signup',  to: 'users#new'  
  resources :users,  only: [:new, :create, :edit, :update, :index]
  resources :items,  only: [:new, :create, :index]
  resources :menus,  only: [:new, :create, :show]
  # resources :orders, only: [:create, :index, :show]
end
