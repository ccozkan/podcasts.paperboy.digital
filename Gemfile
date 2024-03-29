source "https://rubygems.org"
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby "3.2.2"

gem "pg", "~> 1.4"
gem "puma", "~> 6.0"
gem "rails", "~> 7.0.3.1"
gem "sass-rails", ">= 6"
gem "sprockets-rails", require: "sprockets/railtie"
gem "turbolinks", "~> 5.2.0"

gem "activerecord-session_store"
gem "devise"
gem "omniauth"
gem "omniauth-facebook"
gem "omniauth-github"
gem "omniauth-google-oauth2"
gem "omniauth-rails_csrf_protection", "~> 1.0"

gem "friendly_id"
gem "haml"
gem "haml-rails"
gem "pagy"

gem "feedbag", require: false
gem "feedjira", require: false
gem "httparty", require: false

gem "sidekiq", "<8"
gem "sidekiq-cron"
gem "sidekiq-failures", "~> 1.0"

gem "honeybadger", "~> 4.12"

group :development, :test do
  gem "bullet"
  gem "byebug", platforms: %i[mri mingw x64_mingw]
  gem "dotenv-rails"
  gem "factory_bot"
  gem "factory_bot_rails"
  gem "pry"
  gem "pry-doc"
  gem "pry-rails"
  gem "rspec-rails", "~> 6.0.1"
  gem "rubocop"
  gem "rubocop-performance"
  gem "rubocop-rails"
  gem "spring-commands-rspec"
  gem "timecop"
end

group :development do
  gem "annotate"
  gem "html2haml"
  gem "listen", "~> 3.7"
end

group :test do
  gem "codecov", require: false
  gem "shoulda-matchers", "~> 5.2"
end

gem "tzinfo-data", platforms: %i[mingw mswin x64_mingw jruby]

gem "importmap-rails", "~> 1.1"

gem "turbo-rails", "~> 1.4"

# Use Redis for Action Cable
gem "redis", "~> 4.0"

gem "stimulus-rails", "~> 1.2"

gem "active_analytics", "~> 0.2.1"

gem "maintenance_tasks", "~> 2.1"
