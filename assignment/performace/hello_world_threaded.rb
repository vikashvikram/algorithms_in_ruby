threads = []
100.times do
	threads << Thread.new do
		10000.times {puts "Hello World"}
	end
end

threads.map(&:join)

#24s