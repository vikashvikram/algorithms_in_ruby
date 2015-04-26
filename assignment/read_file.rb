require 'benchmark'

Benchmark.bm do |x|
  x.report {File.read('SCC.txt')}
  x.report {File.readlines('SCC.txt')}
  x.report {File.open('SCC.txt').each {|x|}}
end
