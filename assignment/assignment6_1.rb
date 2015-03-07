arr = File.readlines('algo1-programming_prob-2sum.txt').map(&:chomp).map(&:to_i).uniq.sort
input = Hash.new
arr.each {|x| input[x.to_s] = true}
count_arr = (-10000..10000).to_a
count = 0
count_arr.each do |x|
  arr.each do |y|
    s = x-y
    if s != y and input[s.to_s]
      count += 1
      break
    end
  end
end
puts count
