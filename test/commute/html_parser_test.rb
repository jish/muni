require 'minitest/autorun'
require 'commute/html_parser'

describe Commute::HtmlParser do

  it "finds the next times" do
    html = File.read(File.join(__dir__, "..", "files", "prediction_ajax.html"))
    Commute::HtmlParser.new(html).times.must_equal [2, 9, 18]
  end

end
