require 'commute/prediction_fetcher'
require 'commute/html_parser'
require 'commute/prediction_processor'

module Commute
  class Driver

    def call
      html = PredictionFetcher.new.call
      first, second, third = HtmlParser.new(html).times

      puts [first, second, third].join(", ")

      if PredictionProcessor.new(first, second).worth_it?
        puts "SECOND TRAIN #{second}"
        system("say", "second", "train", "leaves", "in", second.to_s, "minutes")
      end

      if PredictionProcessor.new(second, third).worth_it?
        puts "THIRD TRAIN #{third}"
        system("say", "third", "train", "leaves", "in", third.to_s, "minutes")
      end
    end

  end
end
