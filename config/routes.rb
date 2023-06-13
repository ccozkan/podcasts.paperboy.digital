require 'sidekiq/web'
require 'sidekiq/cron/web'

Rails.application.routes.draw do
  authenticate :user, lambda { |u| u.admin?  } do
    mount MaintenanceTasks::Engine => "/admin/maintenance"
    mount Sidekiq::Web => "/admin/sidekiq"
    mount ActiveAnalytics::Engine, at: "/admin/analytics"
  end

  devise_for :users, controllers: { omniauth_callbacks: 'omniauth' }

  root 'pages#home'

  get '/about' => 'pages#about'
  get '/privacy' => 'pages#privacy'
  get '/loading' => 'pages#loading'

  get '/contact' => 'feedbacks#new', as: 'contact_me'
  post '/contact' => 'feedbacks#create'

  get '/play/:slug' => 'play_episodes#show', as: 'player'
  #put '/dismiss/:episode_id' => 'dismiss_episodes#update', as: 'dismiss'

  get '/search' => 'search_feeds#index'
  get '/porch' => 'porch#index'

  resources :settings, only: [:index]
  resources :subscriptions, only: [:index, :create]
  resources :feeds, only: [:show], param: :slug
  resources :episodes, only: [:show], param: :slug
  resources :dismiss_episodes, only: [:update], param: :episode_id
  resources :listen_it_later_episodes, only: [:index, :update], param: :episode_id, path: :later
  resources :unsubscriptions, only: [:destroy], param: :feed_id
end
