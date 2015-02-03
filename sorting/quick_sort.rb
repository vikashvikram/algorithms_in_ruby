module QuickSort
  def quick_sort
    partial_quick_sort(0, length-1)
    self
  end

  def partial_quick_sort(start, ending)
    return if start >= ending
    val = self[start]
    i, j = start, start+1
    j.upto(ending) do |index|
      if self[index] < val
        i += 1
        swap(i, index)
      end
    end
    swap(i,start)
    partial_quick_sort(start, i-1)
    partial_quick_sort(i+1, ending)
  end

  def swap(index1, index2)
    temp = self[index1]
    self[index1] = self[index2]
    self[index2] = temp
  end
end
