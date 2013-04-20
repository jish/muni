module Commute
  class PredictionProcessor
    attr_reader :first, :second

    def initialize(first, second)
      @first, @second = first.to_i, second.to_i
    end

    def worth_it?
      difference = second - first
      second > minutes_to_muni && difference < 5
    end

    def minutes_to_muni
      time = ENV['MINUTES_TO_MUNI'].to_i
      time == 0 ? 8 : time
    end
  end
end
