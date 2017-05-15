source 'http://rubygems.org'

ruby '2.3.1'
gem 'rails', '~> 4.2.5.2'
gem 'rake', '11.3.0'
gem 'pg', '~> 0.18.4'
gem 'haml-rails', '~> 0.9.0'
gem 'devise', '~> 4.2.0'
gem 'devise-i18n'
gem 'doorkeeper', '~> 3.0.1'
gem 'doorkeeper-i18n'
gem 'omniauth', '~> 1.6.1'
gem 'omniauth-google-oauth2', '~> 0.4.1'
gem 'omniauth-facebook', '~> 4.0.0'
gem 'omniauth-twitter', '~> 1.4.0'
gem 'omniauth-github'
gem 'active_model_serializers', '~> 0.8.1'
gem 'private_pub', github: 'loomio/private_pub'
gem 'simple_form', '3.1.0'
gem 'cancancan'
gem 'gravtastic'
gem 'paperclip', '~> 4.3.6'
gem 'activeadmin', github: 'gdpelican/activeadmin'
gem 'nokogiri'
gem 'twitter-text'
gem 'redcarpet', '~> 3.3.4'
gem 'paper_trail', '~> 4.0.2'
gem 'delayed_job', '~> 4.0.2'
gem 'delayed_job_active_record', '~> 4.0.1'
gem 'rinku'
gem 'friendly_id', '~> 5.1.0'
gem 'httparty'
gem 'airbrake', '~> 4.1.0'
gem 'browser', '~> 2.3.0'
gem 'fog'
gem 'thin'
gem 'sequenced', '~> 2.0.0'
gem 'bing_translator', '~> 5.0.0'
gem 'http_accept_language'
gem 'intercom'
gem 'intercom-rails'
gem "font-awesome-sass",  '~> 4.3.2'
gem 'mail', github: 'mikel/mail'
gem 'coffee-rails'
gem 'sprockets-rails', require: 'sprockets/railtie'
gem 'uglifier', '~> 3.0.0'
gem 'bootstrap-sass', '~> 3.3.4'
gem 'sass-rails', '>= 3.2'
gem 'ruby-progressbar'
gem 'activerecord_any_of'
# gem 'rack-attack', '~> 4.4.1'
gem 'ahoy_matey', github: 'gdpelican/ahoy', branch: 'user-presence'
gem 'ahoy_email', '~> 0.3.1'
gem 'oj'
gem 'simple-rss'
gem 'snorlax'
gem 'custom_counter_cache'
gem 'safe_shell'
gem 'premailer-rails'
gem 'griddler', github: 'loomio/griddler'
gem "griddler-mailin", github: 'loomio/griddler-mailin'
gem 'activerecord-import'
gem 'discriminator', '~> 0.1.1'
gem 'has_secure_token'
gem "autoprefixer-rails"
gem 'jquery-ui-rails', '~> 5.0.5'


group :development, :test do
  gem 'minitest'
  gem 'timecop'
  gem 'byebug'
  gem 'rb-readline'
  gem 'factory_girl_rails'
  gem 'faker'
  gem 'shoulda-matchers'
  gem 'dotenv-rails', require: 'dotenv/rails-now'
  gem 'capybara'
  gem 'database_cleaner'
  gem 'selenium-webdriver'
  gem 'gemrat'
end

group :development do
  gem 'sqlite3'
  # gem 'derailed'
  gem "stackprof"
  gem 'spring'
  gem "spring-commands-cucumber"
  gem "spring-commands-rspec"
  gem 'bullet'
  gem 'launchy'
  gem 'awesome_print'
end

group :test do
  gem 's3_uploader'
  gem 'cucumber-rails', require: false
  gem 'email_spec'
  gem 'poltergeist'
  gem 'webmock'
  gem "codeclimate-test-reporter", require: false
  gem 'rack_session_access'
  gem 'rspec-rails'
  gem 'rspec-its'
  gem 'rspec-collection_matchers'
  gem 'rspec-activemodel-mocks'
end

group :production do
  gem 'puma'
  gem 'rails_12factor'
  gem 'rails_serve_static_assets'
  gem 'delayed-plugins-airbrake'
  gem 'dalli'
  gem 'newrelic_rpm'
  gem 'heroku-deflater'
end

Dir.glob(File.join(File.dirname(__FILE__), 'plugins', '**', "Gemfile")) do |gemfile|
  eval(IO.read(gemfile), binding)
end
