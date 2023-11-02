source "https://rubygems.org"

ruby "3.2.2"

gem "rails", "~> 7.1.1"
gem "sprockets-rails"
gem 'pg', '~> 1.5', '>= 1.5.4'
gem "puma", ">= 5.0"
gem "importmap-rails"
gem "tailwindcss-rails"
gem 'redis', '~> 5.0', '>= 5.0.8'
# gem "kredis"
# gem "bcrypt", "~> 3.1.7"
gem "tzinfo-data", platforms: %i[ windows jruby ]
gem "bootsnap", require: false

group :development, :test do
  gem "debug", platforms: %i[ mri windows ]
end

group :development do
  gem "web-console"
  # gem "rack-mini-profiler"
  # gem "spring"
end

group :test do
  # Use system testing [https://guides.rubyonrails.org/testing.html#system-testing]
  gem "capybara"
  gem "selenium-webdriver"
end
