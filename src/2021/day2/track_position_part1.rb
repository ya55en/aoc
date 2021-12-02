#! /usr/bin/env ruby

$v_pos = 0
$h_pos = 0

def process(line)
  case line
  when /^up\s+(\d+)$/ then $v_pos -= $1.to_i
  when /^down\s+(\d+)$/ then $v_pos += $1.to_i
  when /^forward\s+(\d+)$/ then $h_pos += $1.to_i
  else raise "Malformed input: [#{line}]"
  end
end

def main
  $stdin.each { |line| process(line.rstrip) }
  print "h_pos=#{$h_pos}, v_pos=#{$v_pos}, result=#{$h_pos * $v_pos}\n"
end

main if __FILE__ == $0
