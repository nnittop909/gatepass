source 'https://rubygems.org'

git_source(:github) do |repo_name|
  repo_name = "#{repo_name}/#{repo_name}" unless repo_name.include?("/")
  "https://github.com/#{repo_name}.git"
end
ruby '2.5.1'

gem 'rails', '~> 5.2.1'
gem 'pg', '>= 0.18', '< 2.0'
gem 'puma', '~> 3.7'
gem 'sass-rails', '~> 5.0'
gem 'uglifier', '>= 1.3.0'
gem 'coffee-rails', '~> 4.2'
gem 'jbuilder', '~> 2.5'
gem 'jquery-rails'
gem 'jquery-ui-rails'
gem 'rails-jquery-autocomplete'
gem 'simple_form'
gem 'bootstrap-sass'
gem "font-awesome-rails"
gem "animate-rails"
gem 'friendly_id', '~> 5.1.0'
gem 'kaminari'
gem 'pg_search'
gem 'devise'
gem "paperclip", "~> 5.2.0"
gem 'bootstrap-datepicker-rails'
gem 'momentjs-rails', '>= 2.9.0'
gem 'datetimepicker-rails', github: 'zpaulovics/datetimepicker-rails', branch: 'master', submodules: true
gem 'pundit'
gem "select2-rails"
gem 'prawn'
gem 'roo', "~> 2.7.0"
gem 'prawn-table'
gem 'prawn-icon'
gem 'mina-puma', :require => false
gem 'prawn-print'
gem 'whenever', :require => false
gem 'delayed_job_active_record'
gem 'rubyzip', '>= 1.2.1'
gem 'axlsx'
gem 'axlsx_rails'
gem 'bootstrap-popover-rails'
gem 'jquery_fullscreen-rails', '~> 1.1'
gem 'roo-xls'

group :development, :test do
  gem 'byebug', platforms: [:mri, :mingw, :x64_mingw]
  gem 'capybara', '~> 2.13'
  gem 'selenium-webdriver'
end

group :development do
  gem 'web-console', '>= 3.3.0'
  gem 'listen', '>= 3.0.5', '< 3.2'
  gem 'spring'
  gem 'spring-watcher-listen', '~> 2.0.0'
  gem 'factory_bot_rails'
end

# Windows does not include zoneinfo files, so bundle the tzinfo-data gem
gem 'tzinfo-data', platforms: [:mingw, :mswin, :x64_mingw, :jruby]
