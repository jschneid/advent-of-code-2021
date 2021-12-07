def read_positions
  File.open('input.txt', &:readline).split(',').map(&:to_i)
end

def fuel_needed_for_move(position1, position2)
  total_fuel_needed = 0
  fuel_needed_for_next_move = 1
  position1, position2 = position2, position1 if position2 < position1
  while position1 < position2
    total_fuel_needed += fuel_needed_for_next_move
    fuel_needed_for_next_move += 1
    position1 += 1
  end
  total_fuel_needed
end

def least_fuel_needed_for_alignment(positions)
  least_fuel_needed = Float::INFINITY
  (positions.min..positions.max).each do |target_position|
    fuel_needed = 0
    positions.each { |position| fuel_needed += fuel_needed_for_move(position, target_position) }
    least_fuel_needed = fuel_needed if fuel_needed < least_fuel_needed
  end
  least_fuel_needed
end

positions = read_positions
p least_fuel_needed_for_alignment(positions)
