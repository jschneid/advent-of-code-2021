TargetArea = Struct.new :y_range, :x_range do
  def include?(y, x)
    y_range.include?(y) && x_range.include?(x)
  end
end

def read_target_area
  input = File.readlines('input.txt')[0].chomp
  y_range = eval(input.split('=')[2])
  x_range = eval(input.split('=')[1].split(',')[0])
  TargetArea.new(y_range, x_range)
end

def intersects_target?(initial_y_velocity, initial_x_velocity, target_area)
  y = 0
  x = 0
  y_velocity = initial_y_velocity
  x_velocity = initial_x_velocity
  while y >= target_area.y_range.min && x <= target_area.x_range.max
    return true if target_area.include?(y, x)

    y += y_velocity
    y_velocity -= 1
    x += x_velocity
    x_velocity -= 1 if x_velocity.positive?
  end
  false
end

def count_possible_trajectories(target_area)
  possible_y_initial_velocities = (target_area.y_range.min..(target_area.y_range.min * -1))
  possible_x_initial_velocities = (Math.sqrt(target_area.x_range.min).to_i..target_area.x_range.max)

  hits = 0
  possible_y_initial_velocities.each do |initial_y_velocity|
    possible_x_initial_velocities.each do |initial_x_velocity|
      hits += 1 if  intersects_target?(initial_y_velocity, initial_x_velocity, target_area)
    end
  end
  hits
end

p count_possible_trajectories(read_target_area)
