require_relative "./dijkstra"
VERTEX_COUNT = 200
INPUT_FILE = 'dijkstraData.txt'
graph = UndirectedGraph.new(VERTEX_COUNT)
input = File.readlines(INPUT_FILE)
input.each do |each_vertex|
	line = each_vertex.chomp.split("\t")
	node1 = graph.vertex(line.shift.to_i)
	line.each do |tuple|
		label, weight = tuple.split(",").map(&:to_i)
		node2 = graph.vertex(label)
		graph.add_weighted_edge(node1, node2, weight)
	end
end

graph.dijkstra(1)