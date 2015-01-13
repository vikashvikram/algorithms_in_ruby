class NewArray

  attr_reader :arr
  def initialize(arr)
    @arr = arr
  end

  def sequential_search(val)
    arr.each_with_index do |obj, index|
      return index if obj == val
    end 
    nil
  end

##assumes that input array is sorted in ascending order
  def binary_search(val)
    binary_step_search(0, arr.length-1, val)
  end

  private
  def binary_step_search(starting, ending, val)
    return -1 if starting > ending
    mid = (starting + ending)/2
    if arr[mid] == val
      return mid
    elsif arr[mid] > val
      binary_step_search(starting, mid-1, val)
    else
      binary_step_search(mid+1, ending, val)
    end
  end
end
