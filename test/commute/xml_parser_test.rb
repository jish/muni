require 'helper'
require 'commute/xml_parser'

describe Commute::XmlParser do

  include TestHelper

  it "finds the next times" do
    xml = read_fixture_file("prediction.xml")
    Commute::XmlParser.new(xml).times.must_equal [0, 2, 53, 86]
  end

end
