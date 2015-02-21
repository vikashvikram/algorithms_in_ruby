#ADJACENCY LIST datastructure
#undirected graph
class UndirectedGraph
	VERTEX_COUNT = 200
	INPUT_FILE = 'kargerMinCut.txt' #tab separatedintergers in each line ranging from 1 to VERTEX_COUNT 
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
	INPUT_FILE = 'kargerMinCut.txt' #tab separatedintergers in each line ranging from 1 to VERTEX_COUNT 
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
