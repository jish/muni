require 'minitest/autorun'
require 'minitest/pride'

module TestHelper
  def read_fixture_file(file)
    File.read(File.join(File.dirname(__FILE__), "files", file))
  end
end
