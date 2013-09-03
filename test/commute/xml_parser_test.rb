require 'helper'
require 'commute/xml_parser'

describe Commute::XmlParser do

  include TestHelper

  it "finds the next times" do
    xml = read_fixture_file("prediction.xml")
    Commute::XmlParser.new(xml).times.must_equal [0, 2, 53, 86]
  end

  it "reads the messages" do
    xml = read_fixture_file("prediction.xml")
    Commute::XmlParser.new(xml).messages.must_equal [
      "N-Judah to/from Embarcadero only. For Caltrain, use bus shuttle.",
      "N predictions inaccurate near Embarcadero due to construction."
    ]
  end

end
