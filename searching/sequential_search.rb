module SequentialSearch

  def sequential_search(val)
    each_with_index do |obj, index|
      return index if obj == val
    end 
    nil
  end
end
