INPUT_FILE = 'g1.txt'
input_arr = File.readlines(INPUT_FILE)
node_count, edge_count = input_arr.shift.split(" ").map(&:to_i)
# puts node_count
# puts edge_count
arr = Array.new(node_count+1)
(node_count+1).times do |x|
	arr[x] = {}
end

input_arr.each do |entry|
	head, tail, weight = entry.chomp.split(" ").map(&:to_i)
	arr[head][tail.to_s] = weight
end
# puts arr[0]
# puts arr[1]
result = Array.new(node_count+1)
(node_count+1).times do |x|
	result[x] = Array.new(node_count+1)
	(node_count+1).times do |y|
		result[x][y] = Array.new(node_count+1)
	end
end
# puts result[0]
1.upto(node_count) do |i|
	1.upto(node_count) do |j|
		if i == j
			result[i][j][0] = 0
		elsif arr[i][j.to_s]
			result[i][j][0] = arr[i][j.to_s]
		else
			result[i][j][0] = Float::INFINITY
		end
	end
end

1.upto(node_count) do |k|
	1.upto(node_count) do |i|
		1.upto(node_count) do |j|
			a = result[i][j][k-1]
			b = result[i][k][k-1]
			c = result[k][j][k-1]
			result[i][j][k] = [a, b+c].min
	  end
	end
end

no_cycle = 1
1.upto(node_count) do |i|
	if result[i][i][node_count] < 0
		no_cycle = nil
		puts "#{i}--#{i}--NULL"
		break
	end
end

unless no_cycle
	min = result[1][1][0]
	1.upto(node_count) do |i|
		1.upto(node_count) do |j|
			if result[i][j][node_count] < min
				min = result[i][j][node_count]
			end
		end
	end
	puts "min is #{min}"
end


