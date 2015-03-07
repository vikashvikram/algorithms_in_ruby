require_relative "./list_graph"
VERTEX_COUNT = 875714
#VERTEX_COUNT = 14
#INPUT_FILE = 'stronglyConnectedComponents1.txt'
INPUT_FILE = 'SCC.txt'
#INPUT_FILE = 'test1.txt'
graph = DirectedGraph.new(VERTEX_COUNT)
#input = File.readlines(INPUT_FILE)
File.open(INPUT_FILE).each do |each_vertex|
	line = each_vertex.chomp.strip.split(" ").map(&:to_i)
	node1 = graph.vertex(line.shift)
	line.each do |label|
		node2 = graph.vertex(label)
		graph.add_edge(node1, node2)
	end
end
graph.strongly_connected_components