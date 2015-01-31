module MergeSort
  def merge_sort
    partial_merge_sort(0, length-1)
    self
  end

  private
  def partial_merge_sort(start, ending)
    if ending > start
      mid = (start + ending )/2
      partial_merge_sort(start, mid) 
      partial_merge_sort(mid+1, ending)
      merge(start, mid, ending)
    else
      self[start]
    end 
  end

  def merge(start, mid, ending)
    arr = self[start..ending]
    i, j = 0, mid+1-start
    start.upto(ending) do |index|
      if i <= mid-start and (j > ending-start or arr[i] < arr[j])
        self[index] = arr[i]
        i += 1
      else
        self[index] = arr[j]
        j += 1
      end
    end
  end
end
