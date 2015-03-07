#ADJACENCY LIST datastructure
#undirected graph
class UndirectedGraph
	VERTEX_COUNT = 200
	def initialize(number_of_vertices = VERTEX_COUNT)
		@vertices = {}
		number_of_vertices.times {|x| @vertices[(x+1).to_s] = []}
	end

	def vertex(node)
		@vertices[node.to_s]
	end

	def size
		@vertices.count
	end

	def add_vertex(node)
		@vertices[node.to_s] ||= []
	end

	def remove_vertex(node)
		vertex(node).each do |x|
			vertex(x).delete(node)
		end
		@vertices.delete(node.to_s)
	end

	def add_edge(node1,node2)
		vertex(node1) << node2
	    vertex(node2) << node1
	end

	def remove_edge(node1, node2)
		vertex(node1).delete(node2)
		vertex(node2).delete(node1)
	end

	###################KARGER'S MINIMUM CUT ALGORITHM#############################

	def replace_edges(node1, node2)
		vertex(node1).each do |edge|
			add_edge(node2, edge) unless edge == node2
		end
	end

	def contract(node1, node2)
		return if node2 == node1
		replace_edges(node1, node2)
		remove_vertex(node1)
	end

	def minimum_cut
		random_vertex_array = (1..size).to_a.sample(size)
		(size-2).times do
			node1 = random_vertex_array.shift
			node2 = vertex(node1).sample
			contract(node1, node2)
		end
		vertex(random_vertex_array.shift).count
	end

##################SHORTEST PATH ALGO USING BREADTH FIRST SEARCH######################
#g : Undirected graph object and node1, node2 are nodes in g
#g.shortest_path(node1, node2) to calculate shortest path between node1 and node1
#start BFS from node1 and set level 0. If you encounter node2 at level x then shortest distance is x
	def shortest_path(node1, node2)
		@queue = Array.new
		@explored = Array.new(size, false)
		@explored[node1-1] = true
		@queue.push([node1, 0])
		calculate_shortest_path(node2)
	end

	def calculate_shortest_path(dest)
		while entry = @queue.shift
			node, level = entry
			return level if node==dest
			children = vertex(node).uniq
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
#g is Undirected Graph object
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
end