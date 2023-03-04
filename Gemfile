source 'https://rubygems.org'
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby '3.1.0'

gem 'rails', '~> 7.0.3.1'
gem 'pg', '~> 1.4'
gem 'puma', '~> 6.0'
gem 'sass-rails', '>= 6'
gem 'sprockets-rails', require: 'sprockets/railtie'
gem 'turbolinks', '~> 5.2.0'

gem 'devise'
gem 'omniauth'
gem 'omniauth-github'
gem 'omniauth-facebook'
gem 'omniauth-google-oauth2'
gem 'activerecord-session_store'
gem "omniauth-rails_csrf_protection", "~> 1.0"

gem 'haml'
gem 'haml-rails'
gem 'friendly_id'
gem 'pagy'

gem 'httparty', require: false
gem 'feedjira', require: false
gem 'feedbag', require: false

gem "sidekiq", '<7'
gem 'sidekiq-cron'

gem "honeybadger", "~> 4.12"

group :development, :test do
  gem 'byebug', platforms: [:mri, :mingw, :x64_mingw]
  gem 'rubocop'
  gem 'rubocop-rails'
  gem 'rubocop-performance'
  gem 'pry'
  gem 'pry-doc'
  gem 'pry-rails'
  gem 'spring-commands-rspec'
  gem 'rspec-rails', '~> 6.0.1'
  gem 'shoulda-matchers', '~> 5.2'
  gem 'factory_bot'
  gem 'factory_bot_rails'
  gem 'timecop'
  gem 'dotenv-rails'
end

group :development do
  gem 'listen', '~> 3.7'
  gem 'html2haml'
  gem 'annotate'
end

group :test do
  gem 'shoulda-matchers', '~> 5.2'
  gem 'codecov', require: false
end

gem 'tzinfo-data', platforms: [:mingw, :mswin, :x64_mingw, :jruby]
