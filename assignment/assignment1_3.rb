class Edge
  attr_accessor :nodes, :weight, :consumed

  def initialize(node1, node2, weight)
    @nodes = [node1, node2]
    @weight = weight
    @consumed = false
  end

  def consumable?
    !consumed
  end

  def to_s
    "#{nodes}===#{weight}===#{consumed}"
  end
end


INPUT_FILE = 'edges.txt'
input_arr = File.readlines(INPUT_FILE)
nodes, edges = input_arr.shift.split(' ').map(&:to_i)
node_arr = Array.new(nodes, false )
edge_arr = Array.new(edges)
input_arr.each_with_index do |input, index|
  node1, node2, weight = input.split(' ').map(&:to_i)
  edge_arr[index] = Edge.new(node1, node2, weight)
end

consumed_nodes = [1]
sum = 0

loop do
  break if consumed_nodes.count == nodes
  @min, @node, @edge = nil, nil, nil
  edge_arr.select(&:consumable?).each do |edge|
    #puts edge
    both_nodes = edge.nodes
    if consumed_nodes.include? both_nodes[0] and consumed_nodes.include? both_nodes[1]
      edge.consumed = true
      next
    elsif consumed_nodes.include? both_nodes[1]
      unless @min and @min < edge.weight
        @min = edge.weight
        @node = both_nodes[0]
        @edge = edge
      end
    elsif consumed_nodes.include? both_nodes[0]
      unless @min and @min < edge.weight
        @min = edge.weight
        @node = both_nodes[1]
        @edge = edge
      end
    end
  end
  sum += @min
  #puts @node
  @edge.consumed = true
  consumed_nodes << @node
end
puts sum
#ans: -3612829

