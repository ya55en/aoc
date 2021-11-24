#: Unit tests for the utils module.

require 'test/unit'
require_relative './common'
require_relative SRC_DIR + 'utils'

class TestUtils < Test::Unit::TestCase

  TMP_FILE_PATH = '/tmp/tempfile'
  DUMMY_DATA = '111
222
333
'

  def setup
    File.open(TMP_FILE_PATH, 'w') do |f|
      f.write(DUMMY_DATA)
    end
  end

  def teardown
    File.delete(TMP_FILE_PATH) if File.exist?(TMP_FILE_PATH)
  end

  def test_file_to_array
    assert_equal [111, 222, 333], AocUtils.to_int_array(TMP_FILE_PATH)
  end

end
