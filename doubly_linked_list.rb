class DoublyLinkedList

  class IndexOutOfBound < Exception
  end
  attr_accessor :size

  def initialize
    @size = 0
    @front = Node.new(nil, nil, nil)
    @rear = Node.new(nil, nil, nil)
    @front.instance_variable_set(:@next, @rear.object_id)
    @rear.instance_variable_set(:@prev, @front.object_id)
  end

  def empty?
    size.zero?
  end

  def check_index(index)
    raise IndexOutOfBound, "index is out of range" if index > size or index < 0
  end

  def head
    empty? ? nil : @front.getNext
  end

  def tail
    empty? ? nil : @rear.getPrev
  end

  def add(data, index = 0)
    check_index(index)
    add_first(data, false) if index == 0
    get(index-1).setNext(data) if index > 0 and index < size
    @size += 1 
  end

  def add_first(data, increase = true)
    @front.setNext(data)
    @size += 1 if increase
  end

  def add_last(data, increase = true)
    puts "-----------------#{@rear.inspect}--#{@rear.object_id}"
    @rear.setPrev(data)
    @size += 1 if increase
  end

  def get(index)
    check_index(index)
    node = head
    index.times {node = node.getNext}
    return node
  end

  def set(index, data)
    get(index).data = data
  end

  def remove(index)
    check_index(index)
    if index < size
      get(index).detach
      @size -= 1
    end
  end

  def remove_first
  end

  def remove_last
  end

  def to_s
    puts "==--==--==--#{get(size-1)}" if size == 6
    return "" if empty?
    data = []
    node = @front
    size.times {data << (node = node.getNext).data}
    return data.to_s
  end

  class Node
    attr_accessor :data

    def initialize(data, next_node, prev_node)
      @data = data
      @next = next_node.object_id
      @prev = prev_node.object_id
    end

    def getNext
      ObjectSpace._id2ref(@next)
    end

    def getPrev
      ObjectSpace._id2ref(@prev)
    end

    def detach
      getNext.instance_variable_set(:@prev, @prev)
      getPrev.instance_variable_set(:@next, @next)
      @next = nil
      @prev = nil
    end

    def setNext(data)
      node = Node.new(data, getNext, self)
      getNext.instance_variable_set(:@prev, node.object_id)
      @next = node.object_id
      return node
    end

    def setPrev(data)
      puts data
      node = Node.new(data, self, getPrev)
      getPrev.instance_variable_set(:@next, node.object_id)
      @prev = node.object_id
      puts node.inspect
      return node
    end

    def to_s
      "#{data}"
    end
  end

end

list = DoublyLinkedList.new
puts "list.header ==== #{list.head}"
puts "list.header ==== #{list.tail}"
puts "list.size ===== #{list.size}"
puts "list.to_s ==== #{list.to_s}"
list.add(2)
list.add(1)
list.add(3)
puts "list.header ==== #{list.head}"
puts "list.tail ==== #{list.tail}"
puts "list.size ===== #{list.size}"
puts "list.to_s ==== #{list.to_s}" 
list.add(5,2)
puts "list.to_s ==== #{list.to_s}"
list.add(6,3)
puts "list.to_s ==== #{list.to_s}"
puts "list.head ==== #{list.head}"
puts "list.tail ==== #{list.tail}"
puts "list.get(2) ==== #{list.get(2)}"
puts "list.get(2).getNext ==== #{list.get(2).getNext}"
puts "list.get(0).getPrev ==== #{list.head.getPrev}"
list.get(2).setNext(11)
puts "list.to_s ==== #{list.to_s}"
# list.get(3).setPrev(11)
# puts "list.to_s ==== #{list.to_s}"
# list.get(2).data = 19
# puts "list.to_s ==== #{list.to_s}"
# list.remove(2)
# puts "list.to_s ==== #{list.to_s}"
# list.add_first(9)
# puts "list.to_s ==== #{list.to_s}"
# list.add_last(91)
# puts "list.to_s ==== #{list.to_s}"
