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
      data        = PredictionFetcher.new(stop).xml
      parsed_data = XmlParser.new(data)
      times       = parsed_data.times
      messages    = parsed_data.messages

      puts times.join(", ")
      puts messages

      times.first(times.length-1).each_with_index do |current_time, index|
        next_time = times[index+1]
        train_number = index + 2

        if PredictionProcessor.new(current_time, next_time).worth_it?
          puts "TRAIN #{train_number} IN #{next_time}"
          system("say", "train", train_number.to_s, "leaves", "in", next_time.to_s, "minutes")
        end
      end
    end

  end
end
