source 'http://gems.ruby-china.org'

gem 'rails', '~> 5.0.1'
gem 'mysql2', '>= 0.3.18', '< 0.5'
gem 'pg', '~> 0.18'
gem 'puma', '~> 3.9.1'
gem 'sass-rails', '~> 5.0'
gem 'uglifier', '>= 1.3.0'
gem 'coffee-rails', '~> 4.2'
gem 'jquery-rails'
gem 'turbolinks', '~> 5'
gem 'jbuilder', '~> 2.5'
gem 'redis', '~> 3.0'
gem 'oj'
gem 'chartkick'
gem 'twitter-bootstrap-rails', :git => 'git://github.com/seyhunak/twitter-bootstrap-rails.git'
gem 'dalli'
gem 'connection_pool'
gem 'crono'
gem 'daemons'
gem 'haml'
gem 'sinatra', '2.0.0.beta2', require: nil
gem 'rubyzip', '~> 1.1.0'
gem 'axlsx', '2.1.0.pre'
gem 'axlsx_rails'
gem 'httparty'
gem 'wicked_pdf'
gem 'wkhtmltopdf-binary'
gem 'parallel'
gem 'searchkick'
gem 'rack-cors', :require => 'rack/cors'
gem 'modern_times', '0.4.0', :git => 'git@git.huantengsmart.com:CikeyPhantom/modern_times.git'
gem 'aes'
gem 'ruby_original_aes', '0.1.2', github: 'sun1752709589/ruby_original_aes'
gem 'rest-client'
gem 'elasticsearch'
gem 'airbrake', '~> 5.0'
gem 'graphql'
gem 'rack-attack'
gem 'lazy_high_charts'
gem 'cequel'
gem 'activemodel-serializers-xml'
gem 'faker'
gem 'typhoeus'
gem 'china_sms'
gem 'bcrypt'
gem 'rails_bootstrap_navbar'
gem 'puma_worker_killer'
group :development, :test do
  gem 'byebug', platform: :mri
  gem 'pry'
  gem 'pry-nav'
  gem 'awesome_print'
end

group :development do
  gem 'capistrano', '~> 3.5.0'
  gem 'capistrano-container'
  gem 'web-console', '>= 3.3.0'
  gem 'listen', '~> 3.0.5'
  gem 'spring'
  gem 'spring-watcher-listen', '~> 2.0.0'
  gem 'graphiql-rails'
end
gem 'tzinfo-data', platforms: [:mingw, :mswin, :x64_mingw, :jruby]
