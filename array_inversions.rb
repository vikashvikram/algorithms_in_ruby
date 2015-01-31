module ArrayInversion
  def merge_inversions_count
    @merge_count = 0
    merge_count(0, length-1)
    @merge_count
  end

  def simple_inversions_count
    @simple_count = 0
    self.length.times do
      top = shift
      each do |el|
        @simple_count += 1 if el < top
      end
    end
    @simple_count
  end

  private
  def merge_count(start, ending)
    if ending > start
      mid = (start + ending )/2
      merge_count(start, mid) 
      merge_count(mid+1, ending)
      partial_count(start, mid, ending)
    end 
  end

  def partial_count(start, mid, ending)
    arr = self[start..ending]
    i, j = 0, mid+1-start
    start.upto(ending) do |index|
      if i <= mid-start and (j > ending-start or arr[i] < arr[j])
        self[index] = arr[i]
        i += 1
      else
        @merge_count += mid+1-start-i
        self[index] = arr[j]
        j += 1
      end
    end
  end
end
