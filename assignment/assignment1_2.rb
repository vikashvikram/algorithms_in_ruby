class Job
  include Comparable
  attr_accessor :weight, :length

  def initialize (weight, length)
    @weight = weight.to_i
    @length = length.to_i
  end

  def comp_prop
    weight.to_f/length.to_f
  end

  def <=>(an_other)
    val = comp_prop - an_other.comp_prop
    val >= 0 ? 1 : -1
  end

  def to_s
    "weight: #{weight}....length: #{length}"
  end

end

#ans: 67311454237
INPUT_FILE = 'jobs.txt'
input_arr = File.readlines(INPUT_FILE)
total_count = input_arr.shift.to_i
arr = Array.new(total_count)
#puts input_arr
input_arr.each_with_index do |input, index|
  weight, length = input.split(' ')
  arr[index] = Job.new(weight, length)
end

completion_time = 0
sum = 0
arr.sort.reverse.each do |entry|
  completion_time += entry.length
  sum += completion_time*entry.weight
end
puts sum