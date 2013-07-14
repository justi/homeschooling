source 'https://rubygems.org'
ruby "2.0.0"

gem 'devise', :git => "https://github.com/plataformatec/devise.git", :branch => "rails4"
#gem 'devise',    github: 'versioncontrol/devise'
gem 'rails',     github: 'rails/rails'
gem 'arel',      github: 'rails/arel'
gem 'activerecord-deprecated_finders', github: 'rails/activerecord-deprecated_finders'

#gem 'ransack'
gem "paperclip", "~> 3.0"
gem 'geocoder'
gem 'will_paginate', '~> 3.0.0'
gem 'country_select'
gem 'inherited_resources'
gem "json_spec", "~> 1.1.0"
gem "haml", :github => "haml/haml", :branch => "stable"
gem 'haml-rails'
gem 'gmaps4rails'
gem "cancan"
gem 'bootstrap-sass', '~> 2.2.2.0'
gem 'bootswatch-rails'
gem 'simple_form'
gem 'nested_form'#, github: 'mlitwiniuk/nested_form', :branch => 'rails4_compatibility'
gem 'mysql2'
gem 'curb'
gem 'omniauth-facebook'
gem 'omniauth-twitter'
gem 'omniauth-github'
gem 'rest-client'

group :production, :staging do # for heroku deployment
  gem 'pg'
  gem 'rails_12factor'
end

# Gems used only for assets and not required
# in production environments by default.
group :assets do
  gem 'sprockets-rails', github: 'rails/sprockets-rails'
  gem 'sass-rails',   github: 'rails/sass-rails'
  gem 'coffee-rails', github: 'rails/coffee-rails'
  gem 'less-rails', github: 'metaskills/less-rails'

  # See https://github.com/sstephenson/execjs#readme for more supported runtimes
  #gem 'therubyracer', platforms: :ruby
  #gem "therubyracer", :require => 'v8'
  gem 'therubyracer', :platforms => :ruby, :require => 'v8'
  gem 'libv8', '~> 3.11.8', :platform => :ruby

  gem 'uglifier', '>= 1.0.3'
end

gem "factory_girl_rails", "~> 4.0"

group :development, :test do
  gem 'rspec-rails', '~> 2.12.2'
  gem 'capybara', '2.0.2'
  gem 'launchy'
  gem 'database_cleaner', :github => 'bmabey/database_cleaner'
end

gem 'jquery-rails', "~> 2.1.4"

# Turbolinks makes following links in your web application faster. Read more: https://github.com/rails/turbolinks
gem 'turbolinks'

# To use ActiveModel has_secure_password
# gem 'bcrypt-ruby', '~> 3.0.0'

# Build JSON APIs with ease. Read more: https://github.com/rails/jbuilder
# gem 'jbuilder'

# Use unicorn as the app server
# gem 'unicorn'

# Deploy with Capistrano
# gem 'capistrano', group: :development

# To use debugger
# gem 'debugger'
gem 'thin'
