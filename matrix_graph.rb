#ADJACENCY MATRIX datastructure
#undirected graph
class Graph
	attr_reader :matrix
	VERTEX_COUNT=200
	INPUT_FILE = 'kargerMinCut.txt' #tab separatedintergers in each line ranging from 1 to VERTEX_COUNT 
	def initialize
		@matrix = Array.new(VERTEX_COUNT)
		VERTEX_COUNT.times do |x|
			@matrix[x] = Array.new(VERTEX_COUNT,0)
		end
		input = File.readlines(INPUT_FILE)
		input.each do |line|
			line_vertices = line.chomp.split("\t")
			central_vertex = line_vertices.shift.to_i
			line_vertices.each do |ver|
				v = ver.to_i
				@matrix[central_vertex-1][v-1]=1
				@matrix[v-1][central_vertex-1]=1
			end
		end
	end

	def add_edge(u,v)
		@matrix[u-1][v-1] = 1
		@matrix[v-1][u-1] = 1
	end

	def remove_edge(u,v)
		@matrix[u-1][v-1] = 0
		@matrix[v-1][u-1] = 0
	end

	def edges(u)
		edges = []
		@matrix[u-1].each_with_index do |val, index|
			edges << index+1 if val == 1 and index != u
		end
		edges
	end
end
