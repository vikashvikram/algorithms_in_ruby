require_relative "./list_graph"
VERTEX_COUNT = 200
INPUT_FILE = 'kargerMinCut.txt'
graph = UndirectedGraph.new(VERTEX_COUNT)
input = File.readlines(INPUT_FILE)
input.each do |each_vertex|
	line = each_vertex.chomp.split("\t").map(&:to_i)
	node1 = graph.vertex(line.shift)
	line.each do |label|
		node2 = graph.vertex(label)
		graph.add_edge(node1, node2)
	end
end

puts "kargerMinCut: #{graph.minimum_cut}"