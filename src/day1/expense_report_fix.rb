#! /usr/bin/env -S ruby -w

#: AoC Day1 solutions. (See `problems.txt` for the exact problems
#: definitions.)

require 'optparse'
require 'ostruct'

require_relative '../utils'
require_relative './array_ext'

module ExpenseReportFix

  def ExpenseReportFix.scan_pairs(amounts, expected_sum = 2020)
    amounts.scan_pairs do |i, j|
      if amounts[i] + amounts[j] == expected_sum
        return amounts[i] * amounts[j]
      end
    end
    nil
  end

  def ExpenseReportFix.scan_triads(amounts, expected_sum = 2020)
    amounts.scan_triads do |i, j, k|
      if amounts[i] + amounts[j] + amounts[k] == expected_sum
        return amounts[i] * amounts[j] * amounts[k]
      end
    end
    nil
  end

  def ExpenseReportFix.parse(argv)
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

  def ExpenseReportFix.main(argv)
    argv = argv.dup # avoid side effects via ARGV
    begin
      options = ExpenseReportFix.parse(argv)
      meth = ExpenseReportFix.method("scan_#{options.cardinality}".to_sym)
      answer = meth.call AocUtils.file_to_array(argv[0])
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
