Rails.application.routes.draw do
  devise_for :users

  root 'pages#home'

  get '/search' => 'search_feeds#index'
  resources :subscriptions, only: [:index, :create]
end
