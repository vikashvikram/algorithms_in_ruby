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
    arr = []
    start.upto(ending) do |x| arr << self[x] end
    i, j = start, mid+1
    start.upto(ending) do |index|
      if i <= mid and (arr[i] > arr[j] or j > ending)
        self[index] = arr[i]
        i += 1
      else
        self[index] = arr[j]
        j += 1
      end
    end
  end
end
