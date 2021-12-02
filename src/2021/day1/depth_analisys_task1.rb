#! /usr/bin/env ruby

# old = -1
# puts $stdin.map {|l| l.strip.to_i}.inject(-1) {
#   |count, val| count += val > old ? 1 : 0; old = val; count
# }


puts $stdin.lines.map(&:to_i).each_cons(2).count { _1 < _2 }
