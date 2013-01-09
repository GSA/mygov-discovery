source 'https://rubygems.org'

gem 'rails', '3.2.11'

# Bundle edge Rails instead:
# gem 'rails', :git => 'git://github.com/rails/rails.git'

gem 'sqlite3'
gem "therubyracer"
gem 'acts-as-taggable-on'
gem 'postrank-uri'
gem 'addressable'
gem 'metainspector'
gem "pismo"
gem 'resque'
gem 'capistrano'
gem 'markdown-rails'
gem 'redcarpet'

# Gems used only for assets and not required
# in production environments by default.
group :assets do
  gem 'sass-rails',   '~> 3.2.3'
  gem 'coffee-rails', '~> 3.2.1'

  # See https://github.com/sstephenson/execjs#readme for more supported runtimes
  # gem 'therubyracer', :platforms => :ruby

  gem 'uglifier', '>= 1.0.3'
end

group :development, :test do
  gem "rspec-rails"
  gem "capybara"
  gem 'launchy'
  gem 'database_cleaner'
  gem 'shoulda-matchers'
end

group :production do
  gem 'mysql2'
end
