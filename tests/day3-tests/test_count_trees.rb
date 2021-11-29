require 'test/unit'
require_relative '../common'
require_relative SRC_DIR + '/day3/count_trees'

class TestCountTrees < Test::Unit::TestCase

  def test_read_map__test_input
    trees_map = read_map(__dir__ + '/test-input-day3.txt')
    assert_equal 11, trees_map.size
    assert_equal 11, trees_map[0].size
  end

  def test_read_map__problem_input
    trees_map = read_map(SRC_DIR + '/day3/input-day3.txt')
    assert_equal 323, trees_map.size
    assert_equal 31, trees_map[0].size
  end

  def test_count_trees__test_input
    trees_map = read_map(__dir__ + '/test-input-day3.txt')
    assert_equal 2, count_trees(trees_map, 1, 1)
    assert_equal 7, count_trees(trees_map, 1, 3)
    assert_equal 3, count_trees(trees_map, 1, 5)
    assert_equal 4, count_trees(trees_map, 1, 7)
    assert_equal 2, count_trees(trees_map, 2, 1)
  end

  def test_count_trees__problem_input
    filename = (SRC_DIR + '/day3/input-day3.txt')
    trees_map = read_map(filename)
    assert_equal 100, count_trees(trees_map, 1, 1)
    assert_equal 276, count_trees(trees_map, 1, 3)
    assert_equal 85, count_trees(trees_map, 1, 5)
    assert_equal 90, count_trees(trees_map, 1, 7)
    assert_equal 37, count_trees(trees_map, 2, 1)
  end

end
