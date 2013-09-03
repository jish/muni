require 'net/http'
require 'tiny_http'

module Commute
  class PredictionFetcher

    BASE_URL = "http://www.nextmuni.com/predictor/fancyNewPredictionLayer.jsp"
    XML_URL  = "http://webservices.nextbus.com/service/publicXMLFeed"

    ROUTES = { n: "N" }

    DIRECTIONS = { inbound: "N__IB1" }

    STOPS = {
      'duboce_park' => '7318',
      'ninth_judah' => '5194',
      '12_judah'    => '5196'
    }

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

      { a: "sf-muni", r: route, d: direction, s: stop_id }
    end

    def stop_id
      STOPS[self.stop || 'duboce_park']
    end

    def xml
      url = XML_URL + build_query_string
      response = TinyHttp.new.get(url)
      response.body
    end

    def build_query_string
      "?command=predictions&a=sf-muni&r=N&s=%s&useShortTitles=true" % [stop_id]
    end

  end
end
