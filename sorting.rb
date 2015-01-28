module Sorting

  def selection_sort
    each_with_index do |item, index|
      minimum = min_index(index)
      swap(index, minimum)
    end
    self 
  end

  def min_index(start, ending = self.length-1)
    minimum = start
    start.upto(ending) do |x|
      minimum = x if self[x] < self[minimum]
    end
    minimum
  end

  def swap(index1, index2)
    val1 = self[index1]
    self[index1] = self[index2]
    self[index2] = val1
  end

end
