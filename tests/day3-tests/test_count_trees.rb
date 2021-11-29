require 'test/unit'
require_relative '../common'

require_relative SRC_DIR + 'day3/count_trees'

class TestCountTrees < Test::Unit::TestCase

  def test_read_map
    trees_map = read_map(__dir__ + '/test-input-day3.txt')
    assert_equal 11, trees_map.size
    assert_equal 11, trees_map[0].size
  end

  def test_count_trees
    trees_map = read_map(__dir__ + '/test-input-day3.txt')
    assert_equal 7, count_trees(trees_map, 3, 1)
  end

end
