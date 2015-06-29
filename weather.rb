require 'forecast_io'
ForecastIO.api_key = ENV['FORECAST_IO_API_KEY']

class Weather
  EXCLUSION_LIST = 'minutely,hourly,daily,alerts,flags'

  def self.get(lat, lng)
    ForecastIO.forecast(lat, lng, params: {units: 'si',
                                           exclude: EXCLUSION_LIST})
  end

  def self.at_time(lat, lng, time)
    ForecastIO.forecast(lat, lng, time: time.to_i, params: {units: 'si',
                                                            exclude: EXCLUSION_LIST})
  end
end
