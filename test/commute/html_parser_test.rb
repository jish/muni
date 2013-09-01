require 'helper'
require 'commute/html_parser'

describe Commute::HtmlParser do

  it "finds the next times" do
    html = read_fixture_file("prediction_ajax.html")
    Commute::HtmlParser.new(html).times.must_equal [2, 9, 18]
  end

end
