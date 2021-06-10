source 'https://rubygems.org'
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby '2.7.3'

gem 'rails', '~> 6.1.3', '>= 6.1.3.1'
gem 'pg', '~> 1.1'
gem 'puma', '~> 5.0'
gem 'sass-rails', '>= 6'

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

gem 'httparty'
gem 'feedjira'

gem 'sidekiq'
gem 'sidekiq-cron'

gem "honeybadger", "~> 4.0"

group :development, :test do
  gem 'byebug', platforms: [:mri, :mingw, :x64_mingw]
  gem 'rubocop'
  gem 'pry'
  gem 'pry-doc'
  gem 'pry-rails'
  gem 'spring-commands-rspec'
  gem 'rspec-rails', '~> 4.0.2'
  gem 'shoulda-matchers', '~> 4.0'
  gem 'factory_bot'
  gem 'factory_bot_rails'
  gem 'timecop'
  gem 'dotenv-rails'
end

group :development do
  gem 'listen', '~> 3.3'
  gem 'html2haml'
end

group :test do
  gem 'shoulda-matchers', '~> 4.0'
  gem 'codecov', require: false
end


gem 'tzinfo-data', platforms: [:mingw, :mswin, :x64_mingw, :jruby]
