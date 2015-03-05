class MinHeap
	attr_reader :heap
	def initialize(arr)
		@heap = arr.unshift(nil)
		(@heap.length/2).downto(1) do |i|
			heapify(i)
		end
	end

	def extract_min
		min, length = heap[1], heap.length
		heap[1] = nil
		swap(1, length-1)
		heapify(1)
		heap.pop
		return min
	end

	def min
		heap[1]
	end

	def size
		@heap.length-1
	end

	def insert(val)
		heap[heap.length], parent, current = val, parent(heap.length), heap.length
		until heap[parent] <= val
			swap(current, parent)
			current = parent
			parent = parent(parent)
		end
	end


	private
	def parent(i)
		i == 1 ? 1 : i/2
	end

	def left(i)
		2*i
	end

	def right(i)
		2*i+1
	end

	def heapify(i)
		left, right,smallest = left(i), right(i), i
		smallest = left if heap[left] and heap[left] < heap[smallest]
		smallest = right if heap[right] and heap[right] < heap[smallest]
		unless smallest == i
			swap(smallest, i)
			heapify(smallest)
		end
	end

	def swap(i,j)
		temp  = heap[j]
		heap[j] = heap[i]
		heap[i] = temp
	end

end
class MaxHeap
	attr_reader :heap
	def initialize(arr)
		@heap = arr.unshift(nil)
		(@heap.length/2).downto(1) do |i|
			heapify(i)
		end
	end

	def extract_max
		max, length = heap[1], heap.length
		heap[1] = nil
		swap(1, length-1)
		heapify(1)
		heap.pop
		return max
	end

	def max
		heap[1]
	end

	def size
		@heap.length-1
	end

	def insert(val)
		heap[heap.length], parent, current = val, parent(heap.length), heap.length
		until heap[parent] >= val
			swap(current, parent)
			current = parent
			parent = parent(parent)
		end
	end


	private
	def parent(i)
		i == 1 ? 1 : i/2
	end

	def left(i)
		2*i
	end

	def right(i)
		2*i+1
	end

	def heapify(i)
		left, right,maximum = left(i), right(i), i
		maximum = left if heap[left] and heap[left] > heap[maximum]
		maximum = right if heap[right] and heap[right] > heap[maximum]
		unless maximum == i
			swap(maximum, i)
			heapify(maximum)
		end
	end

	def swap(i,j)
		temp  = heap[j]
		heap[j] = heap[i]
		heap[i] = temp
	end

end
