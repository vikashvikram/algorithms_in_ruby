module BubbleSort
  def bubble_sort
    begin
      swapped = false
      0.upto(length-2) do |index|
        if self[index] > self[index+1]
          swap(index, index+1)
          swapped = true
        end
      end
    end while swapped
    self
  end

  def swap(index1, index2)
    temp = self[index1]
    self[index1] = self[index2]
    self[index2] = temp
  end
end
