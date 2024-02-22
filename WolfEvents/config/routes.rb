Rails.application.routes.draw do


  get 'my_profile', to: 'profiles#edit', as: 'my_profile'
  delete 'delete_profile', to: 'profiles#destroy', as: 'delete_profile'
  resources :event_tickets
  resources :profiles



  patch 'update_profile', to: 'profiles#update', as: 'update_profile'
  resources :reviews
  get 'home/index'
  resources :events
  resources :users
  get '/my_tickets', to: 'event_tickets#index', as: 'my_tickets'
  get '/my_reviews', to: 'reviews#my_reviews', as: 'my_reviews'
  get '/all_bookings', to: 'event_tickets#all_bookings', as: 'all_bookings'

  get 'rooms/available', to: 'rooms#available'
  resources :rooms




  root 'home#index'
  resources :sessions, only: [:new, :create, :destroy]
  get 'signup', to: "users#new", as: 'signup'
  get 'login', to: "sessions#new", as: 'login'
  get 'logout', to: "sessions#destroy", as: 'logout'

end
