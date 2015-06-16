require 'grape'
require './event'

module Calendar
  class API < Grape::API
    version 'v1', using: :header, vendor: 'calendar'
    format :json

    resource :events do
      desc 'Get all events'
      get do
        Event.all
      end
    end
  end
end
