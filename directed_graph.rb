class DirectedGraph
	VERTEX_COUNT = 200
	def initialize(number_of_vertices = VERTEX_COUNT)
		@vertices, @incoming_edges = {}, {}
		number_of_vertices.times {|x| @vertices[(x+1).to_s] = []}
		number_of_vertices.times {|x| @incoming_edges[(x+1).to_s] = []}
	end

	def vertex(node)
		@vertices[node.to_s]
	end

	def size
		@vertices.count
	end

	def incoming_vertex(node)
		@incoming_edges[node.to_s]
	end

	def add_vertex(node)
		@vertices[node.to_s] ||= []
		@incoming_edges[node.to_s] ||= []
	end

	def remove_vertex(node)
		vertex(node).each do |x|
			incoming_vertex(x).delete(node)
		end
		@vertices.delete(node.to_s)
	end

	def add_edge(tail, head)
		vertex(tail) << head
	    incoming_vertex(head) << tail
	end

	def remove_edge(tail, head)
		vertex(tail).delete(head)
		incoming_vertex(head).delete(tail)
	end

	#################################TOPOLOGICAL SORT USING DEPTH FIRST SEARCH###############################
#g: Connected Directed Acyclic Graph object
#g.topological_order will return labels of all nodes of graph in topological order
#ALGO:
#SET counter to total nodes count
#start depth first on each node (if not explored already). whereever DFS finishes, assign the current counter
#arange all node labels in order of increasing counters
	def topological_sort
		count = size
		@explored_nodes = Array.new(count, false)
		@current_label = count
		@topological_order = Array.new(count, nil)
		count.times do |label|
			dfs_topological_order(label) unless @explored_nodes[label]
		end
		topological_order
	end

	def dfs_topological_order(label)
		@explored_nodes[label] = true
		vertex(label+1).each do |child|
			dfs_topological_order(child-1) unless @explored_nodes[child-1]
		end
		@topological_order[label] = @current_label
		@current_label -= 1
	end

	def topological_order
		topo_order = Array.new(@vertices.count)
		@topological_order.each_with_index do |val, index|
			topo_order[val-1] = index+1
		end
		topo_order
	end
##########################END#################################################################

#############################STRINGLY CONNECTED COMPONENTS USING DEPTH FIRST SEARCH##########
#g: Directed graph object
#g.strongly_connected_components will return number of component components in top five clusters in graph
#ALGO:

	def strongly_connected_components
		@explored_nodes = Array.new(size, false)
		@finishing_time_arr = Array.new(size)
		@scc = Array.new
		@dfs_queue = Array.new
		@finishing_time_queue = Array.new
		@finishing_time = 0
		calculate_finishing_time
		@leaders = scc_call_order
		calculate_scc
		puts "#{@scc.map(&:count).sort.reverse.take(5)}"
	end

	def calculate_finishing_time
		size.times do |index|
			label = index+1
			unless @explored_nodes[index]
				@explored_nodes[index] = true
				@dfs_queue.push(label)
				dfs_finishing_time
			end
		end
	end

	def dfs_finishing_time
		while label = @dfs_queue.pop
			incoming_vertex(label).each do |child|
				unless @explored_nodes[child-1]
					@explored_nodes[child-1] = true
					@dfs_queue.push(child)
				end
			end
			@finishing_time_queue.push(label)
		end
		while label = @finishing_time_queue.pop
			@finishing_time += 1
			@finishing_time_arr[label-1] = @finishing_time
		end
	end

	def scc_call_order
		topo_order = Array.new(size)
		@finishing_time_arr.each_with_index do |val, index|
			topo_order[val-1] = index+1
		end
		topo_order.reverse
	end

	def calculate_scc
		@scc_explored_nodes = Array.new(size, false)
		@leaders.each do |label|
			unless @scc_explored_nodes[label-1]
				(@components = []) << label
				@dfs_queue.push(label)
				dfs_scc
			end
		end
	end

	def dfs_scc
		while label = @dfs_queue.pop
			@scc_explored_nodes[label-1] = true
			vertex(label).each do |child|
				unless @scc_explored_nodes[child-1]
					@components.push(child)
					@dfs_queue.push(child)
				end
			end
		end
		@scc << @components.uniq
	end
##########################################END######################################################
end