#INPUT: array of numbers from 1 to N with one number missing and one number duplicate
#OUTPUT: print duplicate number
#Runtime Complexity: O(n) with no auxiliary space usage e.g. array, map etc
#e.g. Duplicate number from [1,5,3,9,7,6,2,8,2] will be 2
arr = [1,5,3,9,7,6,2,8,2]
arr.each_with_index do |val, index|
    while val != index+1
      if arr[val-1] == val
          puts "duplicate value is #{val}"
          exit
      end
      arr[index], arr[val-1] = arr[val-1], arr[index]
      val = arr[index]
    end
end
