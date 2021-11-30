#! /usr/bin/env ruby
#: Count trees on the way down with a toboggan

def read_map(filename)
  hsize = (File.open(filename) { |f| next f.readline }).rstrip.size
  res = Array.new(hsize)
  File.open(filename) do |f|
    f.each_line.each_with_index do |l, row|
      res[row] = l.rstrip.each_char.map { |c| c == '#' ? 1 : 0 }
    end
  end
  res
end

def count_trees(woods_map, v_step, h_step, v_start = 0, h_start = 0)
  v = v_start
  h = h_start
  v_size = woods_map.size
  h_size = woods_map[0].size
  count = 0
  while true
    v = v + v_step
    return count if v > v_size - 1
    h = (h + h_step) % h_size
    count += woods_map[v][h] # row first, then column
  end
end

def main(argv)
  filename = argv[0] || './input-day3.txt'
  woods_map = read_map(filename)
  trees_counts = [
    count_trees(woods_map, 1, 1),
    count_trees(woods_map, 1, 3),
    count_trees(woods_map, 1, 5),
    count_trees(woods_map, 1, 7),
    count_trees(woods_map, 2, 1),
  ]
  print "Trees encountered: #{trees_counts}\n"
  print "Multiplied: #{trees_counts.reduce(1, :*)}\n"
  0
end

if __FILE__ == $0
  exit(main ARGV)
end
