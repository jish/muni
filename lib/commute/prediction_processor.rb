module Commute
  class PredictionProcessor
    attr_reader :first, :second

    def initialize(first, second)
      @first, @second = first.to_i, second.to_i
    end

    def worth_it?
      difference = second - first
      second > 8 && difference < 5
    end
  end
end
