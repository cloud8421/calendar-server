require 'bundler'
Bundler.setup

require 'rack/cors'
require 'dotenv'
require 'garner'

Dotenv.load

cache_store = ActiveSupport::Cache::FileStore.new('./tmp')

if ENV['RACK_ENV'] == 'production'
  require 'dalli'
  
  cache_store = ActiveSupport::Cache::MemCacheStore.new(ENV['MEMCACHIER_SERVERS'], {
                                                          namespace: 'calendar_v1',
                                                          compress: true,
                                                          username: ENV['MEMCACHIER_USERNAME'],
                                                          password: ENV['MEMCACHIER_PASSWORD']})

end

Garner.configure do |config|
  config.cache = cache_store
end

require './calendar'

use Rack::Cors do
  allow do
    origins '*'
    resource '*', headers: :any, methods: [:get, :post, :delete]
  end
end

run Calendar::API
