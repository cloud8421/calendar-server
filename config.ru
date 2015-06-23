require 'bundler'
Bundler.setup

require 'rack/cors'
require 'dotenv'

Dotenv.load

require './calendar'

use Rack::Cors do
  allow do
    origins '*'
    resource '*', headers: :any, methods: [:get, :post, :delete]
  end
end

run Calendar::API
