source 'https://rubygems.org'
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby '3.0.2'

# Bundle edge Rails instead: gem 'rails', github: 'rails/rails'
gem 'rails', '~> 6.1.0'
# Use postgresql as the database for Active Record
gem 'pg', '>= 0.18', '< 2.0'
# Use Puma as the app server
gem 'puma'
# Build JSON APIs with ease. Read more: https://github.com/rails/jbuilder
gem 'jbuilder', '~> 2.7'
# Use Redis adapter to run Action Cable in production
gem 'redis', '~> 4.0'
# Use Active Model has_secure_password
# gem 'bcrypt', '~> 3.1.7'

# Use Active Storage variant
# gem 'image_processing', '~> 1.2'

# Reduces boot times through caching; required in config/boot.rb
gem 'bootsnap', '>= 1.4.2', require: false

gem 'rpush'

# Use Rack CORS for handling Cross-Origin Resource Sharing (CORS), making cross-origin AJAX possible
gem 'rack-cors'
gem 'devise'
gem 'devise_token_auth', github: 'lynndylanhurley/devise_token_auth'
gem 'faker', :git => 'https://github.com/faker-ruby/faker.git', :branch => 'master'
gem 'pagy', '~> 4.0'
gem 'geocoder'
gem 'friendly_id', '~> 5.2.4'
gem 'skylight'
gem 'bugsnag'
gem 'dotenv-rails'
gem 'sib-api-v3-sdk', github: 'mhdrahmoun/APIv3-ruby-library'
gem 'telegram-bot-ruby'
gem 'sidekiq'
gem 'globalize', '~> 6.0'
gem 'pg_search'
gem "mini_magick"
gem 'oj'
gem "anycable-rails", "~> 1.0"
gem 'IPinfo'

group :development do
  gem 'listen'
  # Spring speeds up development by keeping your application running in the background. Read more: https://github.com/rails/spring
  gem 'spring'
  gem 'spring-watcher-listen', '~> 2.0.0'

  gem "capistrano", "~> 3.12", require: false
  gem "capistrano-rails", require: false
  gem 'capistrano-rbenv',     require: false
  gem 'capistrano3-nginx'
  gem 'capistrano3-puma', '~> 5.0'
end