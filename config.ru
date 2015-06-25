require 'bundler'
Bundler.setup

require 'rack/cors'
require 'dotenv'
require 'garner'

Garner.configure do |config|
  config.cache = ActiveSupport::Cache::FileStore.new
end

Dotenv.load

require './calendar'

use Rack::Cors do
  allow do
    origins '*'
    resource '*', headers: :any, methods: [:get, :post, :delete]
  end
end

run Calendar::API
