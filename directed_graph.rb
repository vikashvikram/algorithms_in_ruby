class DirectedGraph
	VERTEX_COUNT = 875714
	INPUT_FILE = 'SCC.txt'
	attr_reader :edges, :incoming_edges
	def initialize
		@edges, @incoming_edges = {}, {}
		File.open(INPUT_FILE).each do |line|
			head, tail = line.chomp.strip.split(" ").map(&:to_i)
			@edges[head.to_s] = (@edges[head.to_s] || []) << tail
			@incoming_edges[tail.to_s] = (@incoming_edges[tail.to_s] || []) << head
		end
	end

	def inspect
		"hello"
	end

	def strongly_connected_components
		@explored_nodes = Hash.new(false)
		@finishing_time_arr = {}
		@scc = Array.new
		@finishing_time = 0
		calculate_finishing_time
		@explored_nodes = nil
		@leaders = scc_call_order
		calculate_scc
		puts "#{@scc.map(&:count).sort.reverse.take(5)}"
	end

	def calculate_finishing_time
		VERTEX_COUNT.times do |index|
			label = index+1
			dfs_finishing_time(label) unless @explored_nodes[label.to_s]
		end
	end

	def dfs_finishing_time(label)
		@explored_nodes[label.to_s] = true
		if incoming_edges[label.to_s]
			incoming_edges[label.to_s].each do |child|
				dfs_finishing_time(child) unless @explored_nodes[child.to_s]
			end
		end
		@finishing_time += 1
		@finishing_time_arr[label.to_s] = @finishing_time
	end

	def scc_call_order
		@finishing_time_arr.sort_by(&:reverse).reverse
	end

	def calculate_scc
		@scc_explored_nodes = Hash.new(false)
		@leaders.each do |label_arr|
			label = label_arr[0]
			unless @scc_explored_nodes[label]
				(component = []) << label
				@scc << dfs_scc(label, component)
			end
		end
	end

	def dfs_scc(label, component)
		@scc_explored_nodes[label.to_s] = true
		if edges[label.to_s]
			edges[label.to_s].each do |child|
				unless @scc_explored_nodes[child.to_s]
					component.push(child.to_s)
					dfs_scc(child, component)
				end
			end
		end
		component.uniq
	end
end