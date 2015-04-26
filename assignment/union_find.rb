class UnionFind
  def initialize(arr)
    @leadership_hash = {}; @count = {}; @orig_val = {}
    arr.each   {|elem| set_hash(elem, elem); set_size(elem, 0); @orig_val[elem.to_s] = elem}
  end

  def find(elem)
    elem = get_hash(elem) while get_hash(elem) != elem
    return elem
  end

  def union(elem1, elem2)
    leader1 = find(elem1)
    leader2 = find(elem2)
    unless leader1 == leader2
      size(leader1) > size(leader2) ? set_hash(leader2, leader1) : set_hash(leader1, leader2)
    end
  end

  def to_a
    hash.keys.each do |key|
      leader = find(key)
      uf_hash[leader.to_s] = uf_hash.fetch(leader.to_s, []) << @orig_val[key]
    end
    uf_hash.values
  end

  def cluster(elem)
    leader = find(elem)
    cluster = []
    hash.keys.each {|key| cluster << @orig_val[key] if find(key) == leader}
    cluster
  end

  private

  def set_hash(key, value)
    @leadership_hash[key.to_s] = value
  end

  def get_hash(key)
    @leadership_hash[key.to_s]
  end

  def hash
    @leadership_hash
  end

  def size(elem)
    @count[elem.to_s]
  end

  def set_size(elem, val)
    @count[elem.to_s] = val
  end

  def uf_hash
    @uf_hash ||= {}
  end
end

INPUT_FILE = 'clustering1.txt'
input_arr = File.readlines(INPUT_FILE)
total_nodes = input_arr.shift.to_i
uf = UnionFind.new (1..total_nodes).to_a
edge_hash = {}

input_arr.each_with_index do |input, index|
  node1, node2, weight = input.split(' ').map(&:to_i)
  edge_hash[index.to_s] = {nodes: [node1, node2], weight: weight}
end

num_clusters = total_nodes
result = nil


edge_hash.sort_by {|k,v| v[:weight]}.each do |k, v|
  unless uf.find(v[:nodes][0]) == uf.find(v[:nodes][1])
    if num_clusters > 4
      uf.union(v[:nodes][0], v[:nodes][1])
      num_clusters -= 1
    else
      puts "result ==== #{v[:weight]}"
      result = v[:weight]
      return
    end
  end
end
