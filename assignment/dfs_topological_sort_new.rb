require_relative "./directed_graph"
VERTEX_COUNT = 6
INPUT_FILE = 'topologicalSort.txt'
graph = DirectedGraph.new(VERTEX_COUNT)
input = File.readlines(INPUT_FILE)
input.each do |each_vertex|
	line = each_vertex.chomp.split("\t").map(&:to_i)
	node1 = line.shift
	line.each do |node2|
		graph.add_edge(node1, node2)
	end
end
puts "topological order is #{graph.topological_sort}"