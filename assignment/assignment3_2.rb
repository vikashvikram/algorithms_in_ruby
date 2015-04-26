INPUT_FILE = 'knapsack_big.txt'
input_arr = File.readlines(INPUT_FILE)
input = []
input_arr.each_with_index do |inp, index|
	input[index] = inp.split(' ').map(&:to_i)
end
puts input.to_s
puts input[0][0]

arr = []
arr[0] = Array.new(input[0][0]+1, 0)
1.upto(input[0][1]) do |i|
	arr[i] = []
	(input[0][0]+1).times do |w_i|
		arr[i][w_i] = if w_i < input[i][1]
			arr[i-1][w_i]
		else
			[arr[i-1][w_i], arr[i-1][w_i-input[i][1]]+input[i][0]].max
		end
	end
end
puts arr[input[0][1]][input[0][0]]

#ans: 4243395