module InsertionSort

  def insertion_sort
    if length > 1
      1.upto(length-1) do |index|
        val = self[index]
        (index-1).downto(0) do |index2|
          break unless self[index2] >= val 
          self[index2+1], self[index2] = self[index2], val
        end
      end
    end
    self
  end
end
