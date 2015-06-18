require 'grape'
require './database'

module Calendar
  class API < Grape::API
    version 'v1', using: :header, vendor: 'calendar'
    format :json

    resource :events do
      desc 'Get all events'
      get do
        EventRepository.all
      end
    end
  end
end
