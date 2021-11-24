#! /usr/bin/env -S ruby -w

#: AoC Day1 solutions. (See `problems.txt` for the exact problems
#: definitions.)

require 'optparse'
require 'ostruct'

require_relative '../utils'

module ExpenseReportFix

  extend self

  #: Generate and yield all possible pair combinations of non-repeating
  #: indices i, j for this array.
  def scan_pair_combinations(size)
    0.upto(size - 1) do |i|
      (i + 1).upto(size - 1) do |j|
        yield i, j
      end
    end
  end

  #: Generate and yield all possible triad combinations of non-repeating
  #: indices i, j, k for this array.
  def scan_triad_combinations(size)
    scan_pair_combinations(size) do |i, j|
      (j + 1).upto(size - 1) do |k|
        yield i, j, k
      end
    end
  end

  #: Return a pair of elements out of given array matching predefined
  #: conditions.
  def find_matching_pair(amounts, expected_sum = 2020)
    scan_pair_combinations(amounts.size) do |i, j|
      if amounts[i] + amounts[j] == expected_sum
        return amounts[i], amounts[j]
      end
    end
    nil
  end

  #: Return a triad of elements out of given array matching predefined
  #: conditions.
  def find_matching_triad(amounts, expected_sum = 2020)
    scan_triad_combinations(amounts.size) do |i, j, k|
      if amounts[i] + amounts[j] + amounts[k] == expected_sum
        return amounts[i], amounts[j], amounts[k]
      end
    end
    nil
  end

  def parse(argv)
    # The options specified on the command line will be collected in *options*.
    # We set default values here.
    options = OpenStruct.new
    options.cardinality = :pairs

    opt_parser = OptionParser.new do |opts|
      opts.banner = "Usage: #{File.basename $0} [options] INPUT-FILE"
      opts.separator ""
      opts.separator "Specific options:"
      opts.on('-c', '--cardinality CARDINALITY', [:pairs, :triads, '2', '3'],
              'Define the cardinality of the data scan check.',
              'One of "pairs" (also "2") or "triads" (also "3").',
              'Default: "pairs".') do |cardinality|
        options.cardinality = cardinality.downcase
        options.cardinality = :pairs if options.cardinality == '2'
        options.cardinality = :triads if options.cardinality == '3'
      end

      opts.separator ""
      opts.separator "Common options:"
      opts.on_tail("-h", "--help", "Show this message") do
        puts opts
        exit
      end
    end

    opt_parser.parse!(argv)
    abort('Missing INPUT_FILE. (Try "--help" for usage details.)') if argv.empty?
    abort('Too many INPUT_FILE args. (Try "--help" for usage details.)') if argv.size > 1
    options
  end

  def main(argv)
    argv = argv.dup # avoid side effects via ARGV
    begin
      options = ExpenseReportFix.parse(argv)
      input_ary = AocUtils.file_to_array(argv[0])
      result_ary = case options.cardinality
                   when :pairs then ExpenseReportFix.find_matching_pair input_ary
                   when :triads then ExpenseReportFix.find_matching_triad input_ary
                   else raise "UNREACHABLE: #{__LINE__}"
                   end

      answer = result_ary.reduce(1, :*)
      print "Scan result for #{options.cardinality}, multiplied: #{answer}\n"

    rescue StandardError => err
      print "UNEXPECTED: #{err.class}: #{err.to_s}\n"
      return 2
    end
    0
  end
end

if __FILE__ == $0
  exit(ExpenseReportFix.main ARGV)
end
