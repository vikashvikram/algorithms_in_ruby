module RSelect
  def rselect(index)
    quick_search(0, length-1, index)
  end

  def quick_search(start, ending, index)
    return nil if start >= ending and index != start
    pivot = self[start]
    i, j = start, start+1
    j.upto(ending) do |index2|
      if self[index2] < pivot
        i += 1
        swap(i, index2)
      end
    end
    swap(i,start)
    if i > index
      quick_search(start, i-1, index)
    elsif i < index
      quick_search(i+1, ending, index)
    else
      self[i] 
    end
  end

  def swap(index1, index2)
    temp = self[index1]
    self[index1] = self[index2]
    self[index2] = temp
  end
end
