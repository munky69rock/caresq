# frozen_string_literal: true

source 'https://rubygems.org'

ruby '2.4.1'

git_source(:github) do |repo_name|
  repo_name = "#{repo_name}/#{repo_name}" unless repo_name.include?('/')
  "https://github.com/#{repo_name}.git"
end

gem 'activerecord-clean-db-structure'
gem 'aws-sdk', '~> 2'
gem 'bootstrap', '~> 4.0.0.alpha6'
gem 'carrierwave', '~> 1.0'
gem 'config'
gem 'devise', github: 'plataformatec/devise', branch: :master
gem 'faker' # FIXME
gem 'fog-aws'
gem 'jbuilder', '~> 2.5'
gem 'kaminari'
gem 'marginalia'
gem 'materialize-sass'
gem 'newrelic_rpm'
gem 'pg', '~> 0.18'
gem 'puma', '~> 3.7'
gem 'rails', '~> 5.1.0'
gem 'redcarpet'
gem 'sass-rails', '~> 5.0'
gem 'turbolinks', '~> 5'
gem 'uglifier', '>= 1.3.0'

group :development, :test do
  gem 'byebug', platforms: %i[mri mingw x64_mingw]
  gem 'capybara', '~> 2.13.0'
  # gem 'faker'
  gem 'rspec-rails', '~> 3.5'
  gem 'selenium-webdriver'
end

group :development do
  gem 'listen', '>= 3.0.5', '< 3.2'
  gem 'spring'
  gem 'spring-watcher-listen', '~> 2.0.0'
  gem 'web-console', '>= 3.3.0'

  gem 'bullet'
  gem 'letter_opener'
  gem 'pry-rails'
  gem 'rubocop'
end

# Windows does not include zoneinfo files, so bundle the tzinfo-data gem
gem 'tzinfo-data', platforms: %i[mingw mswin x64_mingw jruby]
