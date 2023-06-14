require 'sidekiq/web'
require 'sidekiq/cron/web'

Rails.application.routes.draw do
  get 'background_processes/controller'
  authenticate :user, lambda { |u| u.admin?  } do
    mount MaintenanceTasks::Engine => "/admin/maintenance-tasks"
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

  get '/loading' => 'loading#loading'
  get '/loading-complete' => 'loading#complete'

  post '/start-worker' => 'background_processes#start_worker', as: 'start_worker'
  post '/check-worker' => 'background_processes#check_worker', as: 'check_worker'

  post '/sneak-peekable' => 'sneak_peek#sneek_peekable'
  post '/start-sneak-peeking' => 'sneak_peek#start_sneak_peeking', as: 'start_sneak_peeking'
  get '/sneaking-and-peeking' => 'sneak_peek#loading', as: 'sneaking_and_peeking'
  get '/sneak-peek/:episode_slug' => 'sneak_peek#show', as: 'sneak_peek'

  resources :settings, only: [:index]
  resources :subscriptions, only: [:index, :create]
  resources :feeds, only: [:show], param: :slug
  resources :episodes, only: [:show], param: :slug
  resources :dismiss_episodes, only: [:update], param: :episode_id
  resources :listen_it_later_episodes, only: [:index, :update], param: :episode_id, path: :later
  resources :unsubscriptions, only: [:destroy], param: :feed_id
end
