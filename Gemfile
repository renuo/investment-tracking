source 'https://rubygems.org'

ruby File.read('.ruby-version').strip

gem 'rails'
gem 'figaro'
gem 'pg'
gem 'awesome_print'
gem 'sass-rails'
gem 'slim-rails'
gem 'uglifier'
gem 'activeresource', github: 'rails/activeresource', branch: 'master'
gem 'bootstrap-sass'
gem 'autoprefixer-rails'

group :development do
  gem 'listen'
  gem 'better_errors'
  gem 'binding_of_caller'
  gem 'letter_opener'
  gem 'spring'
  gem 'spring-commands-rspec'
  gem 'web-console'
end

group :development, :test do
  gem 'byebug'
  gem 'pry-byebug'
  gem 'pry-rails'
end

group :test do
  gem 'capybara'
  gem 'factory_girl_rails'
  gem 'rspec-rails'
  gem 'simplecov', require: false
end

group :production do
  gem 'lograge'
  gem 'newrelic_rpm'
  gem 'rack-timeout'
  gem 'rails_12factor'
  gem 'sentry-raven'
  gem 'puma'
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
