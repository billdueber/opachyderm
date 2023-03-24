# frozen_string_literal: true

source  "https://rubygems.org"

gem "mlibrary_serach_parser"

gem "sinatra", "~> 3"
gem "rack"
gem "puma"

gem "faraday"
gem "httpx"

gem "erubi"

# gem "trailblazer-cells"
# gem "cells-erb"


group :code_quality do
  gem "standard"
  gem "simplecov", "~> 0.22", require: false
end

group :development, :test do
  gem "dotenv", "~> 2.8"
end

group :development do
  gem "rake", "~> 13.0"
  gem "rerun", "~> 0.14"
end

group :test do
  gem "rspec", "~>3"
  gem "capybara", "~> 3.38"
  gem "cuprite", "~> 0.14"
  gem "launchy", "~> 2.5"
  gem "rack-test", "~> 2.0"
end

group :tools do
  gem "amazing_print", "~> 1.4"
  gem "debug", "~> 1.7"
  gem "pry"
end