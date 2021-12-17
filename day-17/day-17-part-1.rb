def read_y_target_area
  eval(File.readlines('input.txt')[0].chomp.split('=')[2])
end

def max_y_if_trajectory_intersects_target(initial_y_velocity, y_target_area)
  y = 0
  max_y = 0
  y_velocity = initial_y_velocity
  while y >= y_target_area.min do
    return max_y if y_target_area.include?(y)

    y += y_velocity
    max_y = y if y > max_y
    y_velocity -= 1
  end
  nil
end

# This solution assumes that the target area is defined such that:
#
# (1) The curve intersecting the target area with the highest max_y is going to be one
# where the x velocity has been reduced to 0 (i.e. the probe is in free-fall); so we
# can ignore the x dimension entirely for this part!
#
# (2) The area is entirely in the negative-y range.
def find_highest_y_trajectory(y_target_area)
  (y_target_area.min * -1).downto(1) do |initial_y_velocity|
    max_y = max_y_if_trajectory_intersects_target(initial_y_velocity, y_target_area)
    return max_y unless max_y.nil?
  end
  nil
end

y_target_area = read_y_target_area
p find_highest_y_trajectory(y_target_area)
