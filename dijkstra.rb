#ADJACENCY LIST datastructure
#undirected graph
class UndirectedGraph
	VERTEX_COUNT = 200
	attr_reader :vertices, :edges
	def initialize(number_of_vertices = VERTEX_COUNT)
		@vertices, @edges = Array.new(number_of_vertices), Array.new(number_of_vertices)
		number_of_vertices.times do |x|
			@edges[x] = []
			@vertices[x] = Node.new(x+1, @edges[x])
		end
	end

	def vertex(label)
		@vertices[label-1]
	end

	def add_vertex(node)
		label = vertices.count+1
		@edges[label-1] = []
		@vertices[label-1] = Node.new(label, @edges[label-1])
	end

	def remove_vertex(node)
		vertex(node.label).edges.each do |e|
			remove_edge(e)
		end
		@vertices[node.label-1] = nil
	end

	def add_edge(node1,node2)
		e = Edge.new(node1.label,node2.label)
		node1.add_edge(e)
		node2.add_edge(e)
	end

	def add_weighted_edge(node1,node2, weight)
		e = Edge.new(node1.label,node2.label, weight)
		node1.add_edge(e)
		node2.add_edge(e)
	end

	def remove_edge(edge)
		node_labels = edge.node_labels
		node_labels.each do |label|
			vertex(label).remove_edge(edge)
		end
	end

	def dijkstra(label)
		@dist_arr = Array.new(vertices.count, nil)
		@dist_arr[label-1] = 0
		@label_distance = {label.to_s => 0}
		next_shortest_node(label)
		puts "#{[7,37,59,82,99,115,133,165,188,197].map {|x| @dist_arr[x-1]}.join(',')}"
	end

	def next_shortest_node(label)
		edges = vertex(label).edges
		edges.each do |edge|
			node_labels = edge.node_labels
			node_labels.each do |node_label|
				unless @dist_arr[node_label-1]
					distance = @dist_arr[label-1] + edge.weight
					unless @label_distance[node_label.to_s] and @label_distance[node_label.to_s] < distance
						@label_distance[node_label.to_s] = distance
					end
				end
			end
		end
		#puts "#{@label_distance}"
		next_node = @label_distance.min_by {|key, val| val}
		if next_node
			@dist_arr[next_node[0].to_i - 1] = next_node[1]
			@label_distance.delete(next_node[0])
			next_shortest_node(next_node[0].to_i)
		end
	end


	class Node
		attr_reader :label, :edges
		def initialize(label=nil, edges=nil)
			@label = label
			@edges = edges
		end

		def add_edge(e)
			(edges << e).uniq!
		end

		def remove_edge(e)
			edges.delete(e)
		end
		
		def ==(node)
			label == node.label rescue false
		end
	end

	class Edge
		attr_reader :node_labels, :weight
		def initialize(u,v,w=1)
			@node_labels, @weight = [u,v], w
		end

		def vertices
			node_labels.sort
		end

		def ==(edge)
			vertices == edge.vertices rescue false
		end
	end

	class Heap
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

		def insert(val)
			heap[heap.length], parent, current = val, parent(heap.length), heap.length
			unless heap[parent] <= val
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
			smallest = left if heap[left] and heap[left][0] < heap[smallest][0]
			smallest = right if heap[right] and heap[right][0] < heap[smallest][0]
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
end

