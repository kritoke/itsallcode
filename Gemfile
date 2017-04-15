source 'http://rubygems.org'
ruby '2.3.1'

gem 'sinatra'
gem 'activerecord', :require => 'active_record'
gem 'sinatra-activerecord', :require => 'sinatra/activerecord'
gem 'rake'
gem 'require_all'
gem 'thin'
gem 'shotgun'
gem 'pry'
gem 'bcrypt'
gem 'yt-core'
gem 'yt-url', '~> 1.0.0.beta2'

group :test do
  gem 'rspec'
  gem 'capybara'
  gem 'rack-test'
  gem 'tux'
  gem 'sqlite3'
  gem 'database_cleaner', git: 'https://github.com/bmabey/database_cleaner.git'
end

group :production do
 gem 'pg'
end
