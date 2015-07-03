require 'grape'
require './database'
require './weather'
require './geo_lookup'
require 'json'
require 'garner/mixins/rack'

def format_errors(errors)
  errors.map.reduce({}) do |memo, e|
    memo[e.attribute_name] ||= []
    memo[e.attribute_name] << e.validation.to_s
    memo
  end
end

module Calendar
  class API < Grape::API
    version 'v1', using: :header, vendor: 'calendar'
    format :json

    helpers Garner::Mixins::Rack

    resource :events do
      desc 'Get all events'
      get do
        events = EventRepository.all
        events.to_a.map(&:to_hash)
      end

      desc 'Create a new event'
      params do
        requires :name, type: String, desc: 'The event name/description'
        requires :starts_at, type: DateTime, desc: 'The start time of the event'
        requires :ends_at, type: DateTime, desc: 'The end time of the event'
      end
      post do
        event = Event.new(
          name: params[:name],
          starts_at: params[:starts_at],
          ends_at: params[:ends_at]
        )
        if event.valid?
          status 201
          event = EventRepository.create(event)
          event.to_hash
        else
          status 406
          format_errors(event.errors)
        end
      end

      desc 'Delete an existing event'
      delete ':id' do
        event = EventRepository.find(params[:id])
        if event
          EventRepository.delete(event)
          status 204
        else
          status 404
          {error: 'Event not found'}
        end
      end
    end

    resource :geo_lookup do
      desc 'Get lat/lng for given address'
      params do
        requires :address, type: String, desc: 'Address'
      end

      get do
        garner
          .key({address: params[:address]})
          .options(expires_in: 24.hours) do
            GeoLookup.coordinates_for(params[:address])
          end
      end
    end

    resource :weather do
      desc 'Get weather information'
      params do
        requires :lat, type: Float, desc: 'Latitude'
        requires :lng, type: Float, desc: 'Longitude'
        requires :time, type: Time, desc: 'Forecast time'
      end
      get do
        garner
          .key({lat: params[:lat], lng: params[:lng]})
          .options(expires_in: 2.minutes) do
            w = Weather.at_time(params[:lat], params[:lng], params[:time])
          end
      end
    end
  end
end
