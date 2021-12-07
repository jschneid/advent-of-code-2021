def read_positions
  File.open('input.txt', &:readline).split(',').map(&:to_i)
end

def least_fuel_needed_for_alignment(positions)
  least_fuel_needed = Float::INFINITY
  (positions.min..positions.max).each do |target_position|
    fuel_needed = 0
    positions.each { |position| fuel_needed += (position - target_position).abs }
    least_fuel_needed = fuel_needed if fuel_needed < least_fuel_needed
  end
  least_fuel_needed
end

positions = read_positions
p least_fuel_needed_for_alignment(positions)
