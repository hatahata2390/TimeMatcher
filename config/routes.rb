Rails.application.routes.draw do

  root 'tops#home'

  get    '/help',     to: 'tops#help'
  get    '/about',    to: 'tops#about'
  get    '/contact',  to: 'tops#contact'
  get    '/login',    to: 'sessions#new'
  post   '/login',    to: 'sessions#create'
  delete '/logout',   to: 'sessions#destroy'

  resources :users
  resources :account_activations, only: [:edit]
  resources :password_resets,     only: [:new, :create, :edit, :update]    
end