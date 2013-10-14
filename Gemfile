source 'https://rubygems.org'

gem 'rails', '3.2.14'

group :production do
  gem 'pg'
  gem 'unicorn'
end

group :development do
  gem 'sqlite3'
end

gem 'declarative_authorization'

gem 'rubycas-client'

gem "activeresource", :require => 'active_resource'
gem 'whenever', :require => false
gem 'jquery-rails'
gem "twitter-bootstrap-rails", "~> 2.2.8"
gem 'jquery-ui-rails', '~> 4.0.4'
gem 'js-routes', :git => 'git://github.com/railsware/js-routes.git'
gem 'ejs'

# Gems used only for assets and not required
# in production environments by default.
group :assets do
  gem 'sass-rails',   '~> 3.2.3'
  gem 'coffee-rails', '~> 3.2.1'
  gem 'therubyracer', '~> 0.11.4'
  gem 'less-rails'
  gem 'less'
  gem 'uglifier', '>= 1.0.3'
end

gem 'capistrano', '< 3.0.0'
gem 'jquery-rails'

# To use debugger
gem 'debugger'
