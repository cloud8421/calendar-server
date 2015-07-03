require 'geokit'

class GeoLookup
  def self.coordinates_for(address)
    return [] if address.blank?

    result = Geokit::Geocoders::GoogleGeocoder.geocode(address)
    result.all.map do |r|
      {lat: r.lat,
       lng: r.lng,
       label: r.full_address}
    end
  end
end
