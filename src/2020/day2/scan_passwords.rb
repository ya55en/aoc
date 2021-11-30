#! /usr/bin/env -S ruby -w

#: AoC Day 2 - Count valid passwords. (See `problems.txt` for the exact
#: problems definitions.)

require 'optparse'
require 'ostruct'

module ScanPasswords

  extend self

  #: Return true if given password matches original shopkeeper's policies
  #: constraints, false otherwise. (See day2/problems.txt for details.)
  def match_constraints_orig?(min, max, char, password)
    count = password.count char
    min <= count && count <= max
  end

  #: Return true if given password matches Toboggan Corporate Policies (TCP)
  #: constraints, false otherwise. (Note that TCP policy authors count from 1.
  #: See day2/problems.txt for details.)
  def match_constraints_tcp?(first, second, char, password)
    (password[first - 1] == char) ^ (password[second - 1] == char)
  end

  #: Return true if given password matches Toboggan Corporate Policies constraints,
  #: false otherwise.
  def password_valid?(line, policy)
    return false if line =~ /^\s*$/
    match_data = line.strip.match(/^(\d+)-(\d+)\s+(\w):\s+(.+)$/)
    raise "Line does NOT match format: [#{line.strip}]" unless match_data
    min_s, max_s, char, password = match_data.captures
    min, max = min_s.to_i, max_s.to_i

    case policy
    when :orig then ScanPasswords.match_constraints_orig? min, max, char, password
    when :tcp then ScanPasswords.match_constraints_tcp? min, max, char, password
    else raise "UNREACHABLE: #{__LINE__} - policy_sym=#{policy.inspect}"
    end
  end

  #: Return the number of valid password entries in `input_file` using a match
  #: policy defined by a method with symbol `match_method_sym`.
  def count_valid_passwords(input_file, policy)
    File.open(input_file) do |f|
      f.inject(0) { |count, l| count += password_valid?(l, policy) ? 1 : 0 }
    end
  end

  def parse(argv)
    # The options specified on the command line will be collected in *options*.
    # We set default values here.
    options = OpenStruct.new
    options.policy = :orig

    opt_parser = OptionParser.new do |opts|
      opts.banner = "Usage: #{File.basename $0} [options] INPUT-FILE"
      opts.separator ""
      opts.separator "Specific options:"
      opts.on('-m', '--match-policy POLICY', [:ORIG, :orig, :TCP, :tcp],
              'One of TCP ("Toboggan Corporate Policy")',
              'or ORIG (the original shopkeeper policy, default)') do |policy|
        options.policy = policy.downcase
      end

      opts.separator ""
      opts.separator "Common options:"
      opts.on_tail("-h", "--help", "Show this message") do
        puts opts
        exit
      end
    end

    opt_parser.parse!(argv)
    try_help_msg = 'Try "--help" for usage details.'
    abort("Missing INPUT_FILE. (#{try_help_msg})") if argv.empty?
    abort("Too many INPUT_FILE args. (#{try_help_msg})") if argv.size > 1
    options
  end

  def main(argv)
    argv = argv.dup # avoid side effects via ARGV
    begin
      options = parse(argv)
      result = count_valid_passwords argv[0], options.policy
      print "Total valid passwords: #{result}\n"

    rescue StandardError => err
      print "UNEXPECTED: #{err.class}: #{err.to_s}\n"
      return 2
    end
    0
  end

end

if __FILE__ == $0
  exit(ScanPasswords.main ARGV)
end
