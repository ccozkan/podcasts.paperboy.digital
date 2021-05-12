Rails.application.routes.draw do
  devise_for :users, controllers: { omniauth_callbacks: 'omniauth' }

  root 'pages#home'

  get '/about' => 'pages#about'
  get '/search' => 'search_feeds#index'
  get '/dashboard' => 'dashboard#index'
  get '/porch' => 'porch#index'

  resources :subscriptions, only: [:create]
end
