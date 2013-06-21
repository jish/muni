require 'net/http'

module Commute
  class PredictionFetcher

    BASE_URL = "http://www.nextmuni.com/predictor/fancyNewPredictionLayer.jsp"

    ROUTES = { n: "N" }

    DIRECTIONS = { inbound: "N__IB1" }

    STOPS = { 'duboce_park' => '7318', 'ninth_judah' => '5194' }

    attr_reader :stop

    def initialize(stop = nil)
      @stop = stop if STOPS.keys.include?(stop)
    end

    def call
      uri = URI.parse(BASE_URL)
      uri.query = URI.encode_www_form(params)
      response = Net::HTTP.get_response(uri)

      response.body
    end

    # query string: ?a=sf-muni&r=N&d=N__IB1&s=7318&ts=4448
    def params
      route     = ROUTES[:n]
      direction = DIRECTIONS[:inbound]
      stop_id   = STOPS[self.stop || 'duboce_park']

      { a: "sf-muni", r: route, d: direction, s: stop_id }
    end

  end
end
