measurements = File.readlines('input.txt').map(&:to_i)

# Hat tip to Nick Vaughan for pointing out that measurements i-1 and i-2
# in each comparison cancel out, and can therefore be omitted!
p (3..measurements.length-1).count { |i| measurements[i-3] < measurements[i] }
