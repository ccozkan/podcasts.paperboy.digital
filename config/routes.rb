Rails.application.routes.draw do
  get 'porch/index'
  get 'dashboard/index'

  devise_for :users, controllers: { omniauth_callbacks: 'omniauth' }

  root 'pages#home'

  get '/search' => 'search_feeds#index'
  resources :subscriptions, only: [:index, :create]
end
