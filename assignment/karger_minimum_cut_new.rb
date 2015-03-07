require_relative "./undirected_graph"
VERTEX_COUNT = 200
INPUT_FILE = 'kargerMinCut.txt'
graph = UndirectedGraph.new(VERTEX_COUNT)
input = File.readlines(INPUT_FILE)
input.each do |each_vertex|
	line = each_vertex.chomp.split("\t").map(&:to_i)
	node1 = line.shift
	line.each do |node2|
		graph.add_edge(node1, node2)
	end
end

#puts "kargerMinCut: #{graph.minimum_cut}"

node1 = ARGV[0].to_i
node2 = ARGV[1].to_i
dist = graph.shortest_path(node1, node2)
if dist
	puts "shortest path between #{ARGV[0]} and #{ARGV[1]} is #{dist}"
else
	puts "There is no path between #{ARGV[0]} and #{ARGV[1]}"
end