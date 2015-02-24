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

	def remove_edge(edge)
		node_labels = edge.node_labels
		node_labels.each do |label|
			vertex(label).remove_edge(edge)
		end
	end

##################SHORTEST PATH ALGO USING BREADTH FIRST SEARCH######################
#g : Undirected graph object and node1, node2 are nodes in g
#g.shortest_path(node1, node2) to calculate shortest path between node1 and node1
#start BFS from node1 and set level 0. If you encounter node2 at level x then shortest distance is x
	def shortest_path(node1, node2)
		@queue = Array.new
		@explored = Array.new(vertices.count, false)
		@explored[node1.label-1] = true
		@queue.push([node1.label, 0])
		calculate_shortest_path(node2)
	end

	def calculate_shortest_path(dest)
		while entry = @queue.shift
			node, level = entry
			return level if vertex(node)==dest
			children = vertex(node).edges.map(&:node_labels).flatten.uniq
			children.each do |child|
				unless @explored[child-1]
					@explored[child-1] = true
					@queue.push([child, level+1])
				end
			end
		end
		return nil
	end

###############################END#################################

###############################CONNECTED COMPONENTS USING BREADTH FIRST SEARCH######################
#g is Directed Graph object
#g.connected_components will return all connecetd components in graph g
#ALGO:
#start BFS on each node (provided not already explored). Include all nodes that are not already explored

	def connected_components
		@explored_nodes = Array.new(vertices.count, false)
		@connected_components = Array.new
		@bfs_queue = Array.new
		vertices.count.times do |index|
			label = index+1
			unless @explored_nodes[index]
				@explored_nodes[index] = true
				(connected_component = []) << label
				@bfs_queue << label
				@connected_components << bfs_connected_components(connected_component)
			end
		end
		@connected_components
	end

	def bfs_connected_components(connected_component)
		while label = @bfs_queue.shift
			children = vertex(label).edges.map(&:node_labels).flatten.uniq
			children.each do |child|
				unless @explored_nodes[child-1]
					@explored_nodes[child-1] = true
					@bfs_queue.push(child)
					connected_component.push(child)
				end
			end
		end
		connected_component.uniq
	end
######################################END#################################

	private :calculate_shortest_path, :bfs_connected_components

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
		attr_reader :node_labels
		def initialize(u,v)
			@node_labels = [u,v]
		end

		def vertices
			node_labels.sort
		end

		def ==(edge)
			vertices == edge.vertices rescue false
		end
	end
end

#ADJACENCY LIST datastructure
#directed graph
class DirectedGraph
	VERTEX_COUNT = 200
	attr_reader :vertices, :edges, :incoming_edges
	def initialize(number_of_vertices = VERTEX_COUNT)
		@vertices, @edges, @incoming_edges = Array.new(number_of_vertices), Array.new(number_of_vertices), Array.new(number_of_vertices)
		number_of_vertices.times do |x|
			@edges[x] = []
			@incoming_edges[x] = []
			@vertices[x] = Node.new(x+1, @edges[x], @incoming_edges[x])
		end
	end

	def vertex(label)
		@vertices[label-1]
	end

	def add_vertex(node)
		label = vertices.count+1
		@edges[label-1] = []
		@incoming_edges[label-1] = []
		@vertices[label-1] = Node.new(label, @edges[label-1], @incoming_edges[label-1])
	end

	def remove_vertex(node)
		vertex(node.label).edges.each do |e|
			remove_edge(e)
		end
		vertex(node.label).incoming_edges.each do |e|
			remove_edge(e)
		end
		@vertices[node.label-1] = nil
	end

	def add_edge(node1,node2)
		e = Edge.new(node1.label,node2.label)
		if vertex(node1.label) and vertex(node2.label)
			node1.add_edge(e)
			node2.add_incoming_edge(e)
		end
	end

	def remove_edge(edge)
		vertex(edge.tail).remove_edge(edge)
		vertex(edge.head).remove_incoming_edge(edge)
	end

#################################TOPOLOGICAL SORT USING DEPTH FIRST SEARCH###############################
#g: Connected Directed Acyclic Graph object
#g.topological_order will return labels of all nodes of graph in topological order
#ALGO:
#SET counter to total nodes count
#start depth first on each node (if not explored already). whereever DFS finishes, assign the current counter
#arange all node labels in order of increasing counters
	#directed connected acyclic graphs only
	def topological_sort
		@explored_nodes = Array.new(vertices.count, false)
		@current_label = vertices.count
		@topological_order = Array.new(vertices.count, nil)
		vertices.count.times do |label|
			dfs_topological_order(label) unless @explored_nodes[label-1]
		end
		topological_order
	end

	def dfs_topological_order(label)
		@explored_nodes[label-1] = true
		vertex(label).edges.map(&:head).each do |child|
			dfs_topological_order(child) unless @explored_nodes[child-1]
		end
		@topological_order[label-1] = @current_label
		@current_label -= 1
	end

	def topological_order
		topo_order = Array.new(vertices.count)
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
		@explored_nodes = Array.new(vertices.count, false)
		@finishing_time_arr = Array.new(vertices.count)
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
		vertices.count.times do |index|
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
			vertex(label).incoming_edges.map(&:tail).each do |child|
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
		topo_order = Array.new(vertices.count)
		@finishing_time_arr.each_with_index do |val, index|
			topo_order[val-1] = index+1
		end
		topo_order.reverse
	end

	def calculate_scc
		@scc_explored_nodes = Array.new(vertices.count, false)
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
			vertex(label).edges.map(&:head).each do |child|
				unless @scc_explored_nodes[child-1]
					@components.push(child)
					@dfs_queue.push(child)
				end
			end
		end
		@scc << @components.uniq
	end
##########################################END######################################################

	private :dfs_topological_order, :topological_order

	class Node
		attr_reader :label, :edges, :incoming_edges
		def initialize(label=nil, edges=nil, incoming_edges=nil)
			@label = label
			@edges = edges
			@incoming_edges = incoming_edges
		end

		def add_edge(e)
			(edges << e).uniq!
		end

		def remove_edge(e)
			edges.delete(e)
		end

		def add_incoming_edge(e)
			(incoming_edges << e).uniq!
		end

		def remove_incoming_edge(e)
			incoming_edges.delete(e)
		end
		
		def ==(node)
			label == node.label rescue false
		end
	end

	class Edge
		attr_reader :node_labels, :head, :tail
		def initialize(u,v)
			@node_labels, @head, @tail = [u,v], v, u
		end

		def vertices
			node_labels.sort
		end

		def ==(edge)
			(head == edge.head and tail == egde.tail) rescue false
		end
	end
end
