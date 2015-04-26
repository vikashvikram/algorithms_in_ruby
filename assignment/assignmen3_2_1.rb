class Knapsack
	attr_accessor :arr, :input
	def initialize(filename)
		input_arr = File.readlines(filename)
		@input = []
		input_arr.each_with_index do |inp, index|
			@input[index] = inp.split(' ').map(&:to_i)
		end
		@arr = []
		@arr[0] = Array.new(input[0][0]+1, 0)
	end

	def execute(w, n = input[0][1])
		@arr[n] = [] unless @arr[n]
		return @arr[n][w] if @arr[n][w]
		x = execute(w, n-1)

		if w-input[n][0] < 0
			@arr[n][w] = x
		else
			y = execute(w-input[n][0], n-1)
			@arr[n][w] = [x, y+input[n][1]].max
		end
		return @arr[n][w]
	end
end


kp = Knapsack.new('knapsack1.txt')
puts kp.execute(kp.input[0][0])