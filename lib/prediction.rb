require 'muni'
require 'muni_estimation'

module Commute
  class Prediction

    def get
      n = Muni::Route.find("N")
      stop = n.inbound.stop_at("Sunset Tunnel East Portal")
      first, second = stop.predictions.first(2).map do |p|
        p.minutes
      end

      puts [first, second].join(", ")

      ::MuniEstimation.new(first, second).worth_it?
    end

  end
end

puts Commute::Prediction.new.get
