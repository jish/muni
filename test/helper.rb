$LOAD_PATH.unshift("lib")

require 'minitest/autorun'
require 'minitest/pride'

class MiniTest::Test
  def read_fixture_file(file)
    File.read(File.join(File.dirname(__FILE__), "files", file))
  end
end
