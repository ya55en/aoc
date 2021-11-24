#: Unit tests for scan_psswds (day-2 part 1 solution).

require 'test/unit'
require 'stringio'

require_relative '../common'
require_relative SRC_DIR + 'day2/scan_passwds'

# Need to isolate in a module to avoid constants' name collisions/side effects
module TestScanPasswdsWrapper

  MY_DIR = File.expand_path File.dirname(__FILE__)
  REF_INPUT_FILE = MY_DIR + '/ref-input-day2.txt'
  PUZZLE_INPUT_FILE = SRC_DIR + 'day2/puzzle-input-day2.txt'

  #: Test match_constraints_xxx? methods
  class TestMatchConstraints < Test::Unit::TestCase

    def test_orig_policy_positive_cases
      assert_true ScanPasswds.match_constraints_orig?(1, 3, 'a', 'abcde')
      assert_true ScanPasswds.match_constraints_orig?(2, 9, 'c', 'ccccccccc')
      assert_true ScanPasswds.match_constraints_orig?(8, 9, 'c', 'c1c2c3c4c5c6c7c8')
    end

    def test_orig_policy_negative_cases
      assert_false ScanPasswds.match_constraints_orig?(1, 3, 'b', 'cdefg')
      assert_false ScanPasswds.match_constraints_orig?(2, 3, 'a', 'abcde')
      assert_false ScanPasswds.match_constraints_orig?(2, 9, 'c', 'cccccccccac')
      assert_false ScanPasswds.match_constraints_orig?(8, 9, 'c', 'c1c2c3c4c5c6c')
    end

    def test_tcp_policy_positive_cases
      assert_true ScanPasswds.match_constraints_tcp?(1, 3, 'a', 'abcde') # found on first idx
      assert_true ScanPasswds.match_constraints_tcp?(2, 9, 'c', 'cxccccccc') # found on second idx
    end

    def test_tcp_policy_negative_cases
      assert_false ScanPasswds.match_constraints_tcp?(1, 3, 'b', 'cdefg') # not found at all
      assert_false ScanPasswds.match_constraints_tcp?(2, 9, 'c', 'ccccccccc') # found on both indices
    end

  end

  #: Test passwd_valid? method for the original psswd policy
  class TestPasswdValidForOrigPolicy < Test::Unit::TestCase

    def test_positive_cases
      assert_true ScanPasswds.passwd_valid? '1-3 a: abcde', :orig
      assert_true ScanPasswds.passwd_valid? '2-9 c: ccccccccc', :orig
    end

    def test_negative_cases
      assert_false ScanPasswds.passwd_valid? '1-3 b: cdefg', :orig
      assert_false ScanPasswds.passwd_valid? '8-9 c: c1c2c3c4c5c6c', :orig
    end
  end

  #: Test passwd_valid? method for the tcp password policy
  class TestPasswdValidForTcpPolicy < Test::Unit::TestCase

    def test_positive_cases
      assert_true ScanPasswds.passwd_valid? '1-3 a: abcde', :tcp
      assert_true ScanPasswds.passwd_valid? '8-9 c: c1c2c3c4c5c6c', :tcp
    end

    def test_negative_cases
      assert_false ScanPasswds.passwd_valid? '1-3 b: cdefg', :tcp
      assert_false ScanPasswds.passwd_valid? '2-9 c: ccccccccc', :tcp
    end
  end

  #: Test count_valid_passwords method for the orig policy
  class TestCountValidPsswdsForOrigPolicy < Test::Unit::TestCase

    def test_count_valid_passwords
      ref_input = File.read(REF_INPUT_FILE)
      fake_io = StringIO.new(ref_input)
      assert_equal 2, ScanPasswds.count_valid_passwords(fake_io, :orig)
    end
  end

  #: Test count_valid_passwords method for the tcp policy
  class TestCountValidPsswdsForTcpPolicy < Test::Unit::TestCase

    def test_count_valid_passwords
      ref_input = File.read(REF_INPUT_FILE)
      fake_io = StringIO.new(ref_input)
      assert_equal 1, ScanPasswds.count_valid_passwords(fake_io, :tcp)
    end
  end

  #: Test main method
  class TestMain < Test::Unit::TestCase

    def test_default_policy # default policy is :orig
      res = nil
      output = TestHelpers.with_captured_stdout do
        res = ScanPasswds.main [REF_INPUT_FILE]
      end
      assert_equal 0, res
      assert_equal 'Total valid passwds: 2', output.strip
    end

    def test_orig_policy
      res = nil
      output = TestHelpers.with_captured_stdout do
        res = ScanPasswds.main [REF_INPUT_FILE, '-m', 'orig']
      end
      assert_equal 0, res
      assert_equal 'Total valid passwds: 2', output.strip
    end

    def test_tcp_policy
      res = nil
      output = TestHelpers.with_captured_stdout do
        res = ScanPasswds.main ['-m', 'tcp', REF_INPUT_FILE]
      end
      assert_equal 0, res
      assert_equal 'Total valid passwds: 1', output.strip
    end

    def test_orig_policy_puzzle_input
      res = nil
      output = TestHelpers.with_captured_stdout do
        res = ScanPasswds.main ['-m', 'orig', PUZZLE_INPUT_FILE]
      end
      assert_equal 0, res
      assert_equal 'Total valid passwds: 458', output.strip
    end

    def test_tcp_policy_puzzle_input
      res = nil
      output = TestHelpers.with_captured_stdout do
        res = ScanPasswds.main ['-m', 'tcp', PUZZLE_INPUT_FILE]
      end
      assert_equal 0, res
      assert_equal 'Total valid passwds: 342', output.strip
    end
  end
end
