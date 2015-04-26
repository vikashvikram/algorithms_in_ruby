class LinkedList
  attr_accessor :size, :top

  def initialize
    @size = 0
    @top = nil
  end

  def empty?
    size.zero?
  end

  def header
    @top ? @top.to_s : nil
  end

  def add(data, index = nil)
    return nil if index and index >= size
    if index
      get(index-1).setNext(data)
    else
      node = Node.new(data, top)
      @top = node
    end
    @size += 1 
  end

  def get(index)
    node = top
    index.times {node = node.getNext}
    return node
  end

  def remove(index)
    node = get(index-1)
    to_be_removed = node.getNext
    node.setNext(to_be_removed.getNext)
    @size -= 1
  end

  def to_s
    return "" if empty?
    data = []
    data << (node = top).data
    (size-1).times {data << (node = node.getNext).data}
    return data.to_s
  end

  class Node
    attr_accessor :data

    def initialize(data, next_node)
      @data = data
      @next = next_node.object_id
    end

    def getNext
      ObjectSpace._id2ref(@next)
    end

    def setNext(data)
      node = Node.new(data, nil)
      next_node_id = instance_variable_get(:@next)
      @next = node.object_id
      node.instance_variable_set(:@next, next_node_id)
      return node
    end

    def to_s
      "#{data}"
    end
  end

end

list = LinkedList.new
puts "list.header ==== #{list.header}"
puts "list.size ===== #{list.size}"
puts "list.to_s ==== #{list.to_s}"
list.add(2)
list.add(1)
list.add(3)
puts "list.header ==== #{list.header}"
puts "list.size ===== #{list.size}"
puts "list.to_s ==== #{list.to_s}"
list.add(5,2)
puts "list.to_s ==== #{list.to_s}"
list.add(6,3)
puts "list.to_s ==== #{list.to_s}"
puts "list.header ==== #{list.header}"
puts "list.get(2) ==== #{list.get(2)}"
puts "list.get(2).getNext ==== #{list.get(2).getNext}"
list.get(2).setNext(11)
puts "list.to_s ==== #{list.to_s}"
list.get(2).data = 19
puts "list.to_s ==== #{list.to_s}"
