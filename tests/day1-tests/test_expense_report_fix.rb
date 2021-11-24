#: Unit tests for the Day-1 solutions.

require 'test/unit'
require_relative '../common'
require_relative SRC_DIR + 'day1/expense_report_fix'

# Need to isolate in a module to avoid constants' name collisions/side effects
module TestExpenseReportWrapper

  MY_DIR = File.expand_path File.dirname(__FILE__)
  REF_INPUT_FILE = MY_DIR + '/ref-input-day1.txt'
  PUZZLE_INPUT_FILE = SRC_DIR + 'day1/puzzle-input-day1.txt'

  REFERENCE_INPUT = AocUtils.file_to_array(REF_INPUT_FILE)
  PUZZLE_INPUT = AocUtils.file_to_array(PUZZLE_INPUT_FILE)

  class TestExpenseFixesDay1 < Test::Unit::TestCase

    test "day1 - reference input" do
      assert_equal 514579, ExpenseReportFix.scan_pairs(REFERENCE_INPUT)
    end

    test "day1 - no solution input" do
      input = [10, 11, 12, 13, 14]
      assert_nil ExpenseReportFix.scan_pairs(input)
    end

    test "day1 problem input" do
      # print "Answer: [#{ExpenseReports.fix_pairs TRUE_INPUT}]\n"
      assert_equal 1006176, ExpenseReportFix.scan_pairs(PUZZLE_INPUT)
    end
  end

  class TestExpenseFixesDay2 < Test::Unit::TestCase

    test "triads - reference test data" do
      assert_equal 241861950, ExpenseReportFix.scan_triads(REFERENCE_INPUT)
    end

    test "triads - no solution input" do
      input = [10, 11, 12, 13, 14]
      assert_nil ExpenseReportFix.scan_triads(input)
    end

    test "triads - problem input" do
      # print "Answer: [#{ExpenseReports.fix_triads TRUE_INPUT}]\n"
      assert_equal 199132160, ExpenseReportFix.scan_triads(PUZZLE_INPUT)
    end
  end

  #: Test count_valid_passwords method
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
