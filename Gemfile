source 'https://rubygems.org'

ruby File.read('.ruby-version').strip

gem 'autoprefixer-rails'
gem 'awesome_print'
gem 'bcrypt'
gem 'bootstrap-sass'
gem 'coffee-rails'
gem 'devise'
gem 'devise-i18n'
gem 'figaro'
gem 'font-awesome-rails'
gem 'goldiloader'
gem 'http_accept_language'
gem 'jquery-rails'
gem 'jquery-turbolinks'
gem 'pg'
gem 'rack-google-analytics'
gem 'rails'
gem 'rails-i18n'
gem 'rails_real_favicon'
gem 'sass-rails'
gem 'simple_form'
gem 'slim-rails'
gem 'turbolinks'
gem 'typescript-rails'
gem 'uglifier'

group :development do
  gem 'better_errors'
  gem 'binding_of_caller'
  gem 'i18n-docs'
  gem 'letter_opener'
  gem 'spring'
  gem 'spring-commands-rspec'
  gem 'web-console'
end

group :development, :test do
  gem 'byebug'
  gem 'pry-byebug'
  gem 'pry-rails'
  gem 'quiet_assets'
end

group :test do
  gem 'capybara'
  gem 'database_cleaner'
  gem 'factory_girl_rails'
  gem 'rspec-rails'
  gem 'simplecov', require: false
end

group :production do
  gem 'lograge'
  gem 'newrelic_rpm'
  gem 'puma'
  gem 'rack-cors', require: 'rack/cors'
  gem 'rack-timeout'
  gem 'rails_12factor'
  gem 'sentry-raven'
end

group :lint do
  gem 'brakeman', require: false
  gem 'mdl', require: false
  gem 'reek', require: false
  gem 'rubocop', require: false
  gem 'scss_lint', require: false
  gem 'slim_lint', require: false
end

eval_gemfile('Gemfile.local.rb') if File.exist?('Gemfile.local.rb')
