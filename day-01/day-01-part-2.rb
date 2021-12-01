measurements = File.readlines('input.txt').map(&:to_i)
p (3..measurements.length-1).count { |i| measurements[i-3..i-1].sum < measurements[i-2..i].sum }
