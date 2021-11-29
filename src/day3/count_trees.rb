#: Count trees on the way down with a toboggan

def read_map(filename)
  hsize = (File.open(filename) { |f| next f.readline }).rstrip.size
  res = Array.new(hsize) { Array.new }
  File.open(filename) do |f|
    f.each_line.each_with_index do |l, row|
      l.rstrip.each_char.each_with_index do |c, col|
        print "[#{c}]"
        res[col][row] = c == '#' ? 1 : 0
      end
      print "\n"
    end
  end
  print "hsize=#{res.size}, vsize=#{res[0].size}\n"
  res
end

def count_trees(woods_map, h_step, v_step, h_start = 0, v_start = 0)
  h = h_start
  v = v_start
  h_size = woods_map.size
  v_size = woods_map[0].size
  count = 0
  while true
    print "h=#{h}, v=#{v}, count=#{count}\n"
    h = (h + h_step) % h_size
    v = v + v_step
    return count if v > v_size - 1
    count += woods_map[h][v]
  end
end

def main argv
  woods_map = read_map('./input-day3.txt')
  0
end

if __FILE__ == $0
  exit(main ARGV)
end
