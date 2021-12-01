measurements = File.readlines('input.txt').map(&:to_i)
p measurements.each_index.count { |i| measurements[i] > measurements[i - 1] }
