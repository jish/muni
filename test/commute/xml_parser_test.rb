require 'helper'
require 'commute/xml_parser'

describe Commute::XmlParser do

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

  describe "Given an XML payload with multiple elevator announcements" do
    let(:xml) { read_fixture_file("prediction_elevator_announcements.xml") }
    subject { Commute::XmlParser.new(xml) }

    describe "#filtered_messages" do
      before do
        @filtered_messages = subject.filtered_messages
      end

      it "filters out results with the word 'elevator'" do
        @filtered_messages.must_equal []
      end
    end
  end

  describe "Given a list of messages with marketing information in them" do
    let(:messages) { ["Follow us on Twitter", "An important announcement"]}
    subject { Commute::XmlParser.new("") }

    describe "Remove marketing messages" do
      it "Ignores the marketing messages" do
        filtered_messages = subject.filter_marketing(messages)
        filtered_messages.must_equal ["An important announcement"]
      end
    end
  end

  describe "Given an XML payload with multiple types of trains" do
    let(:xml) { read_fixture_file("prediction_multi.xml") }
    subject { Commute::XmlParser.new(xml) }

    it "orders the results" do
      subject.times.must_equal [5, 12, 27, 34, 41, 84]
    end
  end

end
