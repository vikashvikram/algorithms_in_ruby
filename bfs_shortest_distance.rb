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
source_label = ARGV[0].to_i
dest_label = ARGV[1].to_i
node1 = graph.vertex(source_label)
node2 = graph.vertex(dest_label)
dist = graph.shortest_path(node1, node2)
if dist
	puts "shortest path between #{ARGV[0]} and #{ARGV[1]} is #{dist}"
else
	puts "There is no path between #{ARGV[0]} and #{ARGV[1]}"
end