module BinarySearch

##assumes that input array is sorted in ascending order
  def binary_search(val)
    binary_step_search(0, self.length-1, val)
  end

  private
  def binary_step_search(starting, ending, val)
    return -1 if starting > ending
    mid = (starting + ending)/2
    if self[mid] == val
      return mid
    elsif self[mid] > val
      binary_step_search(starting, mid-1, val)
    else
      binary_step_search(mid+1, ending, val)
    end
  end

end
