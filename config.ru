require 'bundler'
Bundler.setup

require 'rack/cors'
require './calendar'

use Rack::Cors do
  allow do
    origins '*'
    resource '*', headers: :any, methods: :get
  end
end

run Calendar::API
