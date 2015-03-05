arr = File.readlines('Median.txt').map(&:chomp).map(&:to_i)
#puts "#{arr}"
require_relative 'heap'
min_heap = MinHeap.new([])
max_heap = MaxHeap.new([])
median_arr = Array.new
arr.each do |x|
  if min_heap.min and x >= min_heap.min
    min_heap.insert(x)
    if min_heap.size - max_heap.size == 2
      max_heap.insert(min_heap.extract_min)
    end
  else
    max_heap.insert(x)
    if max_heap.size - min_heap.size == 2
      min_heap.insert(max_heap.extract_max)
    end
  end
  min_heap.size > max_heap.size ? median_arr.push(min_heap.min) : median_arr.push(max_heap.max)
end
sum = median_arr.inject() {|sum, x| sum += x}
#puts "#{median_arr}"
puts "total sum: #{sum} and count: #{median_arr.count}"
