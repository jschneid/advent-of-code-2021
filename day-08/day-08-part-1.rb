output_values = File.readlines('input.txt').map { |line| line.split('|')[1].split(' ') }
p output_values.flatten.count { |value| [2, 3, 4, 7].include?(value.length) }
