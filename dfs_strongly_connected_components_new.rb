require_relative "./directed_graph"
VERTEX_COUNT = 875714
#VERTEX_COUNT = 9
#INPUT_FILE = 'stronglyConnectedComponents.txt'
INPUT_FILE = 'SCC.txt'
graph = DirectedGraph.new(VERTEX_COUNT)
#input = File.readlines(INPUT_FILE)
File.open(INPUT_FILE).each do |each_vertex|
	line = each_vertex.chomp.strip.split(" ").map(&:to_i)
	node1 = line.shift
	line.each do |node2|
		#node2 = graph.vertex(label)
		graph.add_edge(node1, node2)
	end
end
graph.strongly_connected_components