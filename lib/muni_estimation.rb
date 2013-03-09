class MuniEstimation
  attr_reader :first, :second

  def initialize(first, second)
    @first, @second = first, second
  end

  def worth_it?
    difference = second - first
    second > 8 && difference < 5
  end
end
