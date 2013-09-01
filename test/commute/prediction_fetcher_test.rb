require 'minitest/autorun'
require 'commute/prediction_fetcher'
require 'webmock/minitest'
require 'minitest/pride'

describe Commute::PredictionFetcher do

  

  describe "Requesting the xml API" do
    before(:each) do
      url = "http://webservices.nextbus.com/service/publicXMLFeed"
      params = "?command=predictions&a=sf-muni&r=N&s=5194&useShortTitles=true"
      xml = File.read(File.join(File.dirname(__FILE__), "..", "files", "prediction.xml"))
      # stub_request(:get, url + params).to_return(body: xml)

      stub_request(:get, "http://webservices.nextbus.com/service/publicXMLFeed").
        # to_return(:status => 200, :body => "", :headers => {})
        to_return(:body => xml)
    end

    it "should parse the times" do
      fetcher = Commute::PredictionFetcher.new('ninth_judah')
      fetcher.times.must_equal [1, 2, 3, 4]
    end
  end

end
