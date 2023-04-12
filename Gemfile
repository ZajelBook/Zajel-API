# frozen_string_literal: true

source 'https://rubygems.org'
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby '3.2.0'

# Bundle edge Rails instead: gem 'rails', github: 'rails/rails'
gem 'rails', '~> 7.0.0'
# Use postgresql as the database for Active Record
gem 'pg', '>= 0.18', '< 2.0'
# Use Puma as the app server
gem 'puma'
# Build JSON APIs with ease. Read more: https://github.com/rails/jbuilder
gem 'jbuilder', '~> 2.7'
# Use Redis adapter to run Action Cable in production
gem 'redis', '~> 5.0'
# Use Active Model has_secure_password
# gem 'bcrypt', '~> 3.1.7'

# Use Active Storage variant
# gem 'image_processing', '~> 1.2'

# Reduces boot times through caching; required in config/boot.rb
gem 'bootsnap', '>= 1.4.2', require: false

gem 'rpush'

# Use Rack CORS for handling Cross-Origin Resource Sharing (CORS), making cross-origin AJAX possible
gem 'brakeman'
gem 'bundler-audit'
gem 'devise'
gem 'devise_token_auth', github: 'lynndylanhurley/devise_token_auth'
gem 'dotenv-rails'
gem 'faker'
gem 'friendly_id', '~> 5.2.4'
gem 'geocoder'
gem 'globalize', '~> 6.1'
gem 'IPinfo'
gem 'mini_magick'
gem 'newrelic_rpm'
gem 'oj'
gem 'pagy', '~> 6.0'
gem 'pg_search'
gem 'rack-cors'
gem 'sib-api-v3-sdk'
gem 'telegram-bot-ruby'

gem 'chartkick'
gem 'cocoon'
gem 'cssbundling-rails'
gem 'ddtrace', require: 'ddtrace/auto_instrument'
gem 'groupdate'
gem 'jsbundling-rails'
gem 'sprockets-rails'
gem 'stimulus-rails'
gem 'turbo-rails'

group :development do
  gem 'capistrano', '~> 3.12', require: false
  gem 'capistrano3-nginx'
  gem 'capistrano3-puma', '~> 5.0'
  gem 'capistrano-rails', require: false
  gem 'capistrano-rbenv', require: false
  gem 'letter_opener'
  gem 'rubocop-capybara', require: false
  gem 'rubocop-rails', require: false
  gem 'rubocop-rspec', require: false
  gem 'web-console'
end

group :development, :test do
  gem 'factory_bot_rails'
  gem 'rspec-rails'
end

group :test do
  gem 'simplecov', require: false
  gem 'simplecov-json', require: false

  gem 'capybara'
  gem 'selenium-webdriver'
  gem 'webdrivers'
end
