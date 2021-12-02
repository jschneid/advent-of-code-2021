def read_instructions
  File.readlines('input.txt')
end

def final_horizontal_position_and_depth(instructions)
  horizontal_position = 0
  depth = 0
  aim = 0

  instructions.each do |instruction|
    command, value = parse_instruction(instruction)
    horizontal_position, depth, aim = update_state(command, value, horizontal_position, depth, aim)
  end

  [horizontal_position, depth]
end

def parse_instruction(instruction)
  command, value = instruction.split(' ')
  value = value.to_i

  [command, value]
end

def update_state(command, value, horizontal_position, depth, aim)
  case command
  when 'forward'
    horizontal_position += value
    depth += aim * value
  when 'down'
    aim += value
  when 'up'
    aim -= value
  end

  [horizontal_position, depth, aim]
end

instructions = read_instructions
horizontal_position, depth = final_horizontal_position_and_depth(instructions)

p horizontal_position * depth

