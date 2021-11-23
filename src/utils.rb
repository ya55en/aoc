#: Common utilities for AoC solutions project

module AocUtils

  def AocUtils.file_to_array(filename)
    res = []
    File.open(filename) do |f|
      f.each_line do |line|
        res << line.strip.to_i
      end
    end
    res
  end

end
