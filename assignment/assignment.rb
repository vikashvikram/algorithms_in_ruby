module Assignment2
  def quick_sort1
    @comparison1 = 0
    pivot_first(0, length-1)
    puts "pivot first: #{@comparison1}"
    self
  end

  def quick_sort2
    @comparison2 = 0
    pivot_last(0, length-1)
    puts "pivot last: #{@comparison2}"
    self
  end

  def quick_sort3
    @comparison3 = 0
    pivot_median(0, length-1)
    puts "pivot median: #{@comparison3}"
    self
  end

  def pivot_first(start, ending)
    return if start >= ending
    @comparison1 += ending-start
    val = self[start]
    i, j = start, start+1
    j.upto(ending) do |index|
      if self[index] < val
        i += 1
        swap(i, index)
      end
    end
    swap(i,start)
    pivot_first(start, i-1)
    pivot_first(i+1, ending)
  end

  def pivot_last(start, ending)
    return if start >= ending
    @comparison2 += ending-start
    val = self[ending]
    swap(start, ending)
    i, j = start, start+1
    j.upto(ending) do |index|
      if self[index] < val
        i += 1
        swap(i, index)
      end
    end
    swap(i,start)
    pivot_last(start, i-1)
    pivot_last(i+1, ending)
  end

  def pivot_median(start, ending)
    return if start >= ending
    @comparison3 += ending-start
    median_index = get_median_index(start,ending)
    val = self[median_index]
    swap(start, median_index)
    i, j = start, start+1
    j.upto(ending) do |index|
      if self[index] < val
        i += 1
        swap(i, index)
      end
    end
    swap(i,start)
    pivot_median(start, i-1)
    pivot_median(i+1, ending)
  end

  def get_median_index(start, ending)
    middle = (start+ending)/2
    start_middle = self[start]-self[middle]
    middle_end = self[middle]-self[ending]
    end_start = self[ending]-self[start]
    if (start_middle > 0 and end_start > 0) or (start_middle < 0 and end_start < 0)
      return start
    elsif (start_middle > 0 and middle_end > 0) or (start_middle < 0 and middle_end < 0)
      return middle
    else
      return ending
    end
  end

  def swap(index1, index2)
    temp = self[index1]
    self[index1] = self[index2]
    self[index2] = temp
  end
end
