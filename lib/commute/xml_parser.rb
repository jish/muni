require 'nokogiri'

module Commute
  class XmlParser

    attr_reader :xml

    def initialize(xml)
      @xml = xml
    end

    def times
      document.css("predictions prediction").map do |element|
        element.attr("minutes").to_i
      end
    end

    def messages
      document.css("message").map do |element|
        element.attr("text")
      end
    end

    private

    def document
      @document ||= Nokogiri::XML.parse(xml)
    end

  end
end
