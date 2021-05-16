require 'sidekiq/web'
require 'sidekiq/cron/web'

Rails.application.routes.draw do
  scope :monitoring do
    Sidekiq::Web.use Rack::Auth::Basic do |username, password|
      ActiveSupport::SecurityUtils.secure_compare(::Digest::SHA256.hexdigest(username), ::Digest::SHA256.hexdigest(ENV["SIDEKIQ_USERNAME"])) &
        ActiveSupport::SecurityUtils.secure_compare(::Digest::SHA256.hexdigest(password), ::Digest::SHA256.hexdigest(ENV["SIDEKIQ_PASSWORD"]))
    end if Rails.env.production?

    mount Sidekiq::Web, at: '/sidekiq'
  end

  devise_for :users, controllers: { omniauth_callbacks: 'omniauth' }

  root 'pages#home'

  get '/about' => 'pages#about'
  get '/search' => 'search_feeds#index'
  get '/dashboard' => 'dashboard#index'
  get '/porch' => 'porch#index'

  resources :subscriptions, only: [:create]
  resources :unsubscriptions, only: [:destroy], param: :feed_id
end
