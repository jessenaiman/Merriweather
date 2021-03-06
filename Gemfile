require 'rbconfig'
HOST_OS = RbConfig::CONFIG['host_os']
source 'https://rubygems.org'
gem 'rails', '3.2.6'

gem 'mysql2'
gem 'sqlite3'

group :assets do
  gem 'sass-rails',   '~> 3.2.3'
  gem 'coffee-rails', '~> 3.2.1'
  gem 'uglifier', '>= 1.0.3'
  gem 'jquery-ui-rails'
  gem 'jquery_datepicker'
end

gem 'jquery-rails'
gem "haml", ">= 3.1.6"
gem "haml-rails", ">= 0.3.4", :group => :development

group :test, :development do
  gem "rspec-rails", ">= 2.11.0", :group => [:development, :test]
  gem "factory_girl_rails", ">= 3.5.0", :group => [:development, :test]
  gem "email_spec", ">= 1.2.1", :group => :test
  gem "cucumber-rails", ">= 1.3.0", :group => :test, :require => false
end

gem "capybara", ">= 1.1.2", :group => :test
gem "database_cleaner", ">= 0.8.0", :group => :test
gem "launchy", ">= 2.1.0", :group => :test
gem "guard", ">= 0.6.2", :group => :development  
case HOST_OS
  when /darwin/i
    gem 'rb-fsevent', :group => :development
    gem 'growl', :group => :development
  when /linux/i
    gem 'libnotify', :group => :development
    gem 'rb-inotify', :group => :development
  when /mswin|windows/i
    gem 'rb-fchange', :group => :development
    gem 'win32console', :group => :development
    gem 'rb-notifu', :group => :development
end
gem "guard-bundler", ">= 0.1.3", :group => :development
gem "guard-rails", ">= 0.0.3", :group => :development
gem "guard-livereload", ">= 0.3.0", :group => :development
gem "guard-rspec", ">= 0.4.3", :group => :development
gem "guard-cucumber", ">= 0.6.1", :group => :development
gem "devise", ">= 2.1.2"
gem "cancan", ">= 1.6.8"
gem "rolify", ">= 3.1.0"
gem "twitter-bootstrap-rails", ">= 2.0.3", :group => :assets
gem "therubyracer", :group => :assets, :platform => :ruby
gem "simple_form"
gem "will_paginate", ">= 3.0.3"

gem "ckeditor", "3.7.1"
gem "carrierwave"
gem "mini_magick"

gem "rails-backbone"
gem "thin"

gem 'simple_form_fancy_uploads'

gem 'carrierwave'

gem 'geocoder'
gem 'knockout-rails'

gem 'rabl'
gem 'money'
gem 'stringex'
gem 'activemerchant'
gem 'ransack'
gem 'select2-rails'
gem 'awesome_nested_set'
gem 'acts_as_list'
gem 'ffaker'
gem 'state_machine'
gem 'highline'
gem 'paperclip'
gem 'kaminari'
gem 'deface'
gem 'aws-sdk', '~> 1.3.4'
