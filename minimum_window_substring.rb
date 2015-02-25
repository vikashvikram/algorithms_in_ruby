#INPUT: two strings a and b 
#OUTPUT: find the minimum substring in a that contains all the characters of b
#NOTE: b can have repeated characters
module MinimumCoverSubstring
	module_function
	def execute(source_str, query_str)
		count, start, ending, query_str_count = 0, 0, 0, query_str.length
		to_find, has_found = Hash.new(0), Hash.new(0)
		query_str.chars.each {|char| to_find[char] += 1}

		loop do
			break if ending >= source_str.length
			curr = source_str[ending]
			has_found[curr] += 1
			count += 1 if has_found[curr] <= to_find[curr]
			if count == query_str_count
				while has_found[source_str[start]] > to_find[source_str[start]]
					has_found[source_str[start]] -= 1
					start += 1
				end
				puts "#{source_str[start..ending]}"
			end
			ending += 1
		end
	end
end

MinimumCoverSubstring.execute("acbbaca", "aba")
