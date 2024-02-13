Rails.application.routes.draw do


  
  resources :event_tickets
  resources :rooms
  get 'my_profile', to: 'profiles#edit', as: 'my_profile'
  patch 'update_profile', to: 'profiles#update', as: 'update_profile'
  resources :reviews
  # get 'sessions/newcreatedestroy'
  get 'home/index'
  resources :events
  # # get 'sessions/newcreatedestroy'
  # get 'home/index'
  resources :users

  # delete '/events/:id', to: 'events#destroy'
  get 'rooms/available', to: 'rooms#available'




  root 'home#index'
  resources :sessions, only: [:new, :create, :destroy]
  get 'signup', to: "users#new", as: 'signup'
  get 'login', to: "sessions#new", as: 'login'
  get 'logout', to: "sessions#destroy", as: 'logout'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html

  

end
