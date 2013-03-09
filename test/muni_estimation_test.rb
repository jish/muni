require 'minitest/autorun'
require 'muni_estimation'

describe MuniEstimation do
  describe "Given a second estimation longer than 8 minutes away" do
    before do
      @second = 15
    end

    describe "Given a time difference of 4 minutes or less" do
      before do
        @first = 11
      end

      it "is worth it" do
        assert MuniEstimation.new(@first, @second).worth_it?
      end
    end

    describe "Given a time difference 5 minutes or greater" do
      before do
        @first = 10
      end

      it "is not worth it" do
        assert !MuniEstimation.new(@first, @second).worth_it?
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
        assert !MuniEstimation.new(@first, @second).worth_it?
      end
    end

    describe "Given a time difference of 5 minutes or more" do
      before do
        @first = @second - 5
      end

      it "is not worth it" do
        assert !MuniEstimation.new(@first, @second).worth_it?
      end
    end
  end
end
