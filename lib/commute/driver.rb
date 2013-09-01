require 'commute/prediction_fetcher'
require 'commute/xml_parser'
require 'commute/prediction_processor'

module Commute
  class Driver

    attr_reader :stop

    def initialize(stop = nil)
      @stop = stop
    end

    def call
      data = PredictionFetcher.new(stop).times
      first, second, third, fourth = XmlParser.new(data).times

      puts [first, second, third, fourth].join(", ")

      if PredictionProcessor.new(first, second).worth_it?
        puts "SECOND TRAIN #{second}"
        system("say", "second", "train", "leaves", "in", second.to_s, "minutes")
      end

      if PredictionProcessor.new(second, third).worth_it?
        puts "THIRD TRAIN #{third}"
        system("say", "third", "train", "leaves", "in", third.to_s, "minutes")
      end

      if PredictionProcessor.new(third, fourth).worth_it?
        puts "FOURTH TRAIN #{fourth}"
        system("say", "fourth", "train", "leaves", "in", fourth.to_s, "minutes")
      end
    end

  end
end
