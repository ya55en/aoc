#: Unit tests for the Day-1 solutions.

require 'test/unit'
require_relative '../common'
require_relative SRC_DIR + 'day1/expense_report_fix'

# Isolate tests in a module to avoid constants' name collisions/side effects
module TestExpenseReportWrapper

  MY_DIR = File.expand_path File.dirname(__FILE__)
  REF_INPUT_FILE = MY_DIR + '/ref-input-day1.txt'
  PUZZLE_INPUT_FILE = SRC_DIR + 'day1/puzzle-input-day1.txt'

  REFERENCE_INPUT = AocUtils.file_to_array(REF_INPUT_FILE)
  PUZZLE_INPUT = AocUtils.file_to_array(PUZZLE_INPUT_FILE)

  class TestArrayExtentions < Test::Unit::TestCase

    def test_scan_pairs__size_3
      res = []
      ExpenseReportFix.scan_pair_combinations(3) { |i, j| res << [i, j] }
      assert_equal [[0, 1], [0, 2], [1, 2]], res
    end

    def test_scan_pairs__size_0
      res = []
      ExpenseReportFix.scan_pair_combinations(0) { |i, j| res << [i, j] }
      assert_equal [], res
    end

    def test_scan_pairs__size_1
      res = []
      ExpenseReportFix.scan_pair_combinations(1) { |i, j| res << [i, j] }
      assert_equal [], res
    end

    def test_scan_triads__size_4
      res = []
      ExpenseReportFix.scan_triad_combinations(4) { |i, j, k| res << [i, j, k] }
      assert_equal [[0, 1, 2], [0, 1, 3], [0, 2, 3], [1, 2, 3]], res
    end

    def test_scan_triads__size_5
      res = []
      ExpenseReportFix.scan_triad_combinations(5) { |i, j, k| res << [i, j, k] }
      assert_equal 10, res.size
    end

    def test_scan_triads__size_0
      res = []
      ExpenseReportFix.scan_pair_combinations(0) { |i, j| res << [i, j] }
      assert_equal [], res
    end

  end

  class TestFindMatchingPairMethod < Test::Unit::TestCase

    test "day1 - reference input" do
      assert_equal [1721, 299], ExpenseReportFix.find_matching_pair(REFERENCE_INPUT)
    end

    test "day1 - no solution input" do
      input = [10, 11, 12, 13, 14]
      assert_nil ExpenseReportFix.find_matching_pair(input)
    end

    test "day1 problem input" do
      # print "Answer: [#{ExpenseReports.fix_pairs TRUE_INPUT}]\n"
      assert_equal [892, 1128], ExpenseReportFix.find_matching_pair(PUZZLE_INPUT)
    end
  end

  class TestFindMatchingTriadMethod < Test::Unit::TestCase

    test "triads - solve reference input" do
      assert_equal [979, 366, 675], ExpenseReportFix.find_matching_triad(REFERENCE_INPUT)
    end

    test "triads - return nil if no match" do
      input = [10, 11, 12, 13, 14]
      assert_nil ExpenseReportFix.find_matching_triad(input)
    end

    test "triads - solve problem input" do
      # print "Answer: [#{ExpenseReports.fix_triads TRUE_INPUT}]\n"
      assert_equal [874, 890, 256], ExpenseReportFix.find_matching_triad(PUZZLE_INPUT)
    end
  end

  #: Test ExpenseReportFix.main method
  class TestMainWithRefInput < Test::Unit::TestCase

    def test_cardinality_pairs
      res = nil
      output = TestHelpers.with_captured_stdout do
        res = ExpenseReportFix.main [REF_INPUT_FILE]
      end
      assert_equal 0, res
      assert_equal 'Scan result for pairs, multiplied: 514579', output.strip
    end

    def test_cardinality_triads
      res = nil
      output = TestHelpers.with_captured_stdout do
        res = ExpenseReportFix.main ['-c', 'triads', REF_INPUT_FILE]
      end
      assert_equal 0, res
      assert_equal 'Scan result for triads, multiplied: 241861950', output.strip
    end
  end
end
