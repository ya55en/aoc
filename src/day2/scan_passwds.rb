#! /usr/bin/env -S ruby -w

#: AoC Day 2 - Count valid passwords. (See `problems.txt` for the exact
#: problems definitions.)

require 'optparse'
require 'ostruct'

module ScanPasswds

  extend self

  #: Return true if given passwd matches original shopkeeper's policies
  #: constraints, false otherwise. (See day2/problems.txt for details.)
  def match_constraints_orig?(min, max, char, passwd)
    count = passwd.count char
    min <= count && count <= max
  end

  #: Return true if given passwd matches Toboggan Corporate Policies (TCP)
  #: constraints, false otherwise. (Note that TCP policy authors count from 1.
  #: See day2/problems.txt for details.)
  def match_constraints_tcp?(first, second, char, passwd)
    (passwd[first - 1] == char) ^ (passwd[second - 1] == char)
  end

  #: Return true if given passwd matches Toboggan Corporate Policies constraints,
  #: false otherwise.
  def passwd_valid?(line, policy)
    match_data = line.strip.match(/^(\d+)-(\d+)\s+(\w):\s+(.+)$/)
    raise "Line does NOT match format: [#{line.strip}]" unless match_data
    min_s, max_s, char, passwd = match_data.captures
    min, max = min_s.to_i, max_s.to_i

    case policy
    when :orig then ScanPasswds.match_constraints_orig? min, max, char, passwd
    when :tcp then ScanPasswds.match_constraints_tcp? min, max, char, passwd
    else raise "UNREACHABLE: #{__LINE__} - policy_sym=#{policy.inspect}"
    end
  end

  #: Return the number of valid password entries in `input_file` using a match
  #: policy defined by a method with symbol `match_method_sym`.
  def count_valid_passwords(input_file, policy)
    count = 0
    file_obj = input_file.respond_to?(:read) ? input_file : File.open(input_file)
    file_obj.each_line do |line|
      next if line =~ /^\s*$/
      count += 1 if passwd_valid?(line, policy)
    end
    count
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
      print "Total valid passwds: #{result}\n"

    rescue StandardError => err
      print "UNEXPECTED: #{err.class}: #{err.to_s}\n"
      return 2
    end
    0
  end

end

if __FILE__ == $0
  exit(ScanPasswds.main ARGV)
end
