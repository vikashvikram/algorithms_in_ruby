require 'ruby_collections'

INPUT_FILE = 'clustering1.txt'
input_arr = File.readlines(INPUT_FILE)
total_nodes = input_arr.shift.to_i
uf = RubyCollections::UnionFind.new (1..total_nodes).to_a
edge_hash = {}

input_arr.each_with_index do |input, index|
  node1, node2, weight = input.split(' ').map(&:to_i)
  edge_hash[index.to_s] = {nodes: [node1, node2], weight: weight}
end

num_clusters = total_nodes
result = nil

##answer: 106
edge_hash.sort_by {|k,v| v[:weight]}.each do |k, v|
  unless uf.find(v[:nodes][0]) == uf.find(v[:nodes][1])
    if num_clusters > 4
      uf.union(v[:nodes][0], v[:nodes][1])
      num_clusters -= 1
    else
      puts "result ==== #{v[:weight]}"
      result = v[:weight]
      exit
    end
  end
end
