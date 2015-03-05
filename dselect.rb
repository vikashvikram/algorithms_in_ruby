module DSelect
  def dselect(index)
    return nil if index > length-1 or index < 0
    quick_search_d(0, length-1, index)
  end

  def quick_search_d(start, ending, index)
    puts "#{self}.quick_search_d(start:#{start},ending:#{ending},index:#{index})"
    return nil if start > ending and index != start
    pivot = d_pivot(start, ending)
    i = j = start
    pivot_point = nil
    j.upto(ending) do |index2|
      if self[index2] < pivot
        swap(i, index2) if i != index2
        i += 1
      end
      pivot_point = index2 if self[index2] == pivot
    end
    swap(i,pivot_point)
    if pivot_point > index
      quick_search_d(start, pivot_point-1, index)
    elsif pivot_point < index
      quick_search_d(pivot_point+1, ending, index)
    else
      self[pivot_point] 
    end
  end

  def d_pivot(start, ending)
    puts "#{self}.d_pivot(start:#{start},ending:#{ending})"
    return self[start] if start >= ending
    median_arr = []
    start.step(ending, 5) do |i|
      min = [i+4, ending].min
      median_arr << self[i..min]
    end
    median_arr.each do |ar| ar.sort! end
    medians = median_arr.map do |m| m[(m.length-1)/2] end
    NewArray.new(medians).dselect((medians.length-1)/2)
  end

  def swap(index1, index2)
    temp = self[index1]
    self[index1] = self[index2]
    self[index2] = temp
  end
end
