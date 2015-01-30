module MergeSort
  def merge_sort
    partial_merge_sort(0, length-1)
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
  end
end
