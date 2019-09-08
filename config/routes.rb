Rails.application.routes.draw do

  root 'tops#home'

  get    '/help',     to: 'tops#help'
  get    '/about',    to: 'tops#about'
  get    '/contact',  to: 'tops#contact'
  get    '/login',    to: 'sessions#new'
  post   '/login',    to: 'sessions#create'
  delete '/logout',   to: 'sessions#destroy'

  resources :users do
    member do
      get :list, :like_sending, :like_receiving
    end
  end
  resources :account_activations, only: [:edit]
  resources :password_resets,     only: [:new, :create, :edit, :update]
  resources :like_relationships,  only: [:create]
  resources :rooms,               only: [:index, :show]
  resources :favorites,           only: [:create, :show]
end