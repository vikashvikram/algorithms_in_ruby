require 'ruby_collections'

class HammingDistance
  def self.calculate(a, b)
    a = a.split(' ')
    b = b.split(' ')
    sum = 0
    b.each_with_index {|val, i| sum += 1 if val!=a[i]}
    sum
  end

  def self.randomization(a)
    chars = a.split(" ").map(&:to_i)
    arrs = []
    chars.count.times do |index|
      arr = chars.dup
      arr[index] = 1-arr[index]
      arrs << arr.join(" ")
      (index+1).upto(chars.count-1) do |new_index|
        new_arr = arr.dup
        new_arr[new_index] = 1-new_arr[new_index]
        arrs << new_arr.join(" ")
      end
    end
    arrs
  end
end

b = "0 1 1 0 0 1 1 0 0 1 0 1 1 1 1 1 1 0 1 0 1 1 0 1"
a = "0 1 0 0 0 1 0 0 0 1 0 1 1 1 1 1 1 0 1 0 0 1 0 1"
puts HammingDistance.calculate(a, b)

INPUT_FILE = 'clustering_big.txt'
input_arr = File.readlines(INPUT_FILE)
total_nodes, num_bits = input_arr.shift.split(' ').map(&:to_i)
uf = RubyCollections::UnionFind.new (1..total_nodes).to_a
# edge_hash = {}
# node_hash = {}
# input_arr.each_with_index do |x, index|
#   count = x.chars.count("1").to_s
#   node_hash[count] = node_hash.fetch(count, []) << x
#   edge_hash[x] = index+1
# end

sorted_array = input_arr.sort_by {|x| x.chars.count("1")}

puts sorted_array.take(10)

sorted_array.each do |x|
  count = x.chars.count("1")
  y = x
  while (y = y.next).chars.count("1") - count <= 1
    dist = HammingDistance.calculate(y, x)
    if dist
  end
end

# 2.upto(24) do |x|
#   nodes = node_hash[x.to_s]
#   nodes.each do |p_node|
#     y = x
#     y.upto(x+2) do |count|
#       c_nodes = node_hash[count.to_s]
#       c_nodes.each do |each_node|
#         dist = HammingDistance.calculate(each_node, p_node)
#         if each_node != p_node and dist < 3
#           node1 = edge_hash[each_node]
#           node2 = edge_hash[p_node]
#           if uf.find(node2) != uf.find(node1)
#             uf.union(node2, node1)
#           end
#         end
#       end
#     end
#   end
# end

#puts uf.to_a.count