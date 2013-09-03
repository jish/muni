require 'helper'
require 'commute/prediction_fetcher'
require 'webmock/minitest'

describe Commute::PredictionFetcher do

  describe "Requesting the xml API" do
    before(:each) do
      url = "http://webservices.nextbus.com/service/publicXMLFeed"
      @xml = read_fixture_file("prediction.xml")
      stub_request(:get, url).to_return(:body => @xml)
    end

    it "should fetch xml" do
      fetcher = Commute::PredictionFetcher.new('ninth_judah')
      fetcher.xml.must_equal @xml
    end
  end

end
