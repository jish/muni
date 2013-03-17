require 'nokogiri'

module Commute
  class HtmlParser

    attr_reader :html

    def initialize(html)
      @html = html
    end

    def times
      numbers_in_selector(".predictionNumberForFirstPred .right") +
      numbers_in_selector(".predictionNumberForOtherPreds .right")
    end

    protected

    def numbers_in_selector(selector)
      document.css(selector).map { |node| get_number(node) }
    end

    def document
      @document ||= Nokogiri::HTML.parse(html)
    end

    def get_number(node)
      match = node.text.match(/\d+/)
      match[0].to_i
    end

  end
end
