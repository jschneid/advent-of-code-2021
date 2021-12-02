def read_instructions
  File.readlines('input.txt')
end

def final_horizontal_position_and_depth(instructions)
  horizontal_position = 0
  depth = 0

  instructions.each do |instruction|
    command, value = parse_instruction(instruction)
    horizontal_position, depth = update_horizontal_position_and_depth(command, value, horizontal_position, depth)
  end

  [horizontal_position, depth]
end

def parse_instruction(instruction)
  command, value = instruction.split(' ')
  value = value.to_i

  [command, value]
end

def update_horizontal_position_and_depth(command, value, horizontal_position, depth)
  case command
  when 'forward'
    horizontal_position += value
  when 'down'
    depth += value
  when 'up'
    depth -= value
  end

  [horizontal_position, depth]
end

instructions = read_instructions
horizontal_position, depth = final_horizontal_position_and_depth(instructions)

p horizontal_position * depth

