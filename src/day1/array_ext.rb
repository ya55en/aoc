#: Extend Array with scan_zzz methods (see method docs).

class Array

  #: Generate and yield all possible pair combinations of non-repeating
  #: indices i, j for this array.
  def scan_pairs
    0.upto(size - 1) do |i|
      (i + 1).upto(size - 1) do |j|
        yield i, j
      end
    end
  end

  #: Generate and yield all possible triad combinations of non-repeating
  #: indices i, j, k for this array.
  def scan_triads
    scan_pairs do |i, j|
      (j + 1).upto(size - 1) do |k|
        yield i, j, k
      end
    end
  end

end
