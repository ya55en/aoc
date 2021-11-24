#: Common utilities for AoC solutions project

module AocUtils

  extend self

  def to_int_array(filename)
    File.open(filename) do |f|
      f.each_line.map { |l| l.strip.to_i }
    end
  end

end
