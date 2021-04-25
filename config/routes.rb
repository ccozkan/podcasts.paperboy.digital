Rails.application.routes.draw do
  devise_for :users

  root 'pages#home'

  get '/search' => 'pages#search'
  resources :subscriptions, only: [:index, :create]
end
