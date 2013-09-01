require 'helper'
require 'commute/prediction_processor'

describe Commute::PredictionProcessor do
  describe "Given a second estimation longer than 8 minutes away" do
    before do
      @second = 15
    end

    describe "Given a time difference of 4 minutes or less" do
      before do
        @first = @second - 4
      end

      it "is worth it" do
        assert Commute::PredictionProcessor.new(@first, @second).worth_it?
      end
    end

    describe "Given a time difference 5 minutes or greater" do
      before do
        @first = @second - 5
      end

      it "is not worth it" do
        assert !Commute::PredictionProcessor.new(@first, @second).worth_it?
      end
    end
  end

  describe "Given a MINUTES_TO_MUNI time set by the user" do
    before do
      ENV['MINUTES_TO_MUNI'] = '10'
    end

    describe "Given a time difference of 4 minutes or less" do
      before do
        @second = 9
        @first = @second - 4
      end

      it "is not worth it" do
        assert !Commute::PredictionProcessor.new(@first, @second).worth_it?
      end
    end
  end

  describe "Given a second estimation less than 8 minutes away" do
    before do
      @second = 7
    end

    describe "Given a time difference of 4 minutes or less" do
      before do
        @first = @second - 4
      end

      it "is not worth it" do
        assert !Commute::PredictionProcessor.new(@first, @second).worth_it?
      end
    end

    describe "Given a time difference of 5 minutes or more" do
      before do
        @first = @second - 5
      end

      it "is not worth it" do
        assert !Commute::PredictionProcessor.new(@first, @second).worth_it?
      end
    end
  end

  it "should take predictions in string format" do
    assert Commute::PredictionProcessor.new("10", "12").worth_it?
  end
end
