#! /usr/bin/env ruby

#: An accumulator for summing up measurements of a scan "window" of several
#: input values.
class Accu
  attr_reader :count

  def initialize
    reset
  end

  def reset
    @count = -1
  end

  def set(value)
    @count = value
  end

  def add(value)
    # The `@count < 0` check prevents updating second and third counters
    # on process startup.
    @count += value unless @count < 0
  end
end

#: A set of three counter objects with facilities allowing for tracking
#: (and counting) the changes in three-step input value windows.
class Counters
  attr_reader :increase_count

  def initialize
    @counters = Array.new(3) { Accu.new }
    @index = -1
    @graduated_value = -1
    @increase_count = -1
  end

  #: Handle the event of a counter being updated three times (hence
  #: "graduating" from updates and ready to report a final value).
  def graduate(offset)
    if @counters[offset].count > @graduated_value
      @increase_count += 1
    end
    @graduated_value = @counters[offset].count
    @counters[offset].reset
  end

  #: Process a single line from input, containing an int value. This includes
  #: updating the counter objects appropriately and sending the one ready to
  #: "graduation" procedure.
  def process(line)
    @index += 1
    offset = @index % 3
    value = line.rstrip.to_i
    @counters[offset].set value
    @counters[offset - 1].add value
    @counters[offset - 2].add value
    graduate offset - 2
  end
end

def main
  counters = Counters.new
  $stdin.each { |line| counters.process(line) }
  printf "Increased %u times\n", counters.increase_count
end

main if __FILE__ == $0
