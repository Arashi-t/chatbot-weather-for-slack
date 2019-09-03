require 'geocoder'
require 'redis'

module Weather
  module Geocode
    module_function

    Geocoder.configure(cache: Redis.new(url: ENV['REDIS_URL']))

    # Geocodeで緯度経度を検索
    def search(text)
      # defaultは東京都
      place_name = text || '東京都'

      results = Geocoder.search(place_name).first
      return if results.nil?

      { 'lat' => results.latitude, 'lon' => results.longitude }
    end
  end
end
