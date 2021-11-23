#: Unit tests for array_ext.rb

require 'test/unit'
require_relative '../common'
require_relative SRC_DIR + 'day1/array_ext'

class TestArrayExtentions < Test::Unit::TestCase

  def test_scan_pairs
    arr = [0, 1, 2]
    res = []
    arr.scan_pairs { |i, j| res << [i, j] }
    assert_equal [[0, 1], [0, 2], [1, 2]], res
  end

  def test_scan_pairs__empty_array
    arr = []
    res = []
    arr.scan_pairs { |i, j| res << [i, j] }
    assert_equal [], res
  end

  def test_scan_pairs__single_elem_array
    arr = [1]
    res = []
    arr.scan_pairs { |i, j| res << [i, j] }
    assert_equal [], res
  end

  def test_scan_triads
    arr = [0, 1, 2, 3]
    res = []
    arr.scan_triads { |i, j, k| res << [i, j, k] }
    assert_equal [[0, 1, 2], [0, 1, 3], [0, 2, 3], [1, 2, 3]], res
  end

  def test_scan_triads_5_elem_array
    arr = [0, 1, 2, 3, 4]
    res = []
    arr.scan_triads { |i, j, k| res << [i, j, k] }
    assert_equal 10, res.size
  end

  def test_scan_triads__empty_array
    arr = []
    res = []
    arr.scan_pairs { |i, j| res << [i, j] }
    assert_equal [], res
  end

end
