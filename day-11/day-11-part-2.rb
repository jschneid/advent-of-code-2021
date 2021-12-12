def read_grid
  File.readlines('input.txt').map(&:chomp).map(&:chars).map { |row| row.map(&:to_i) }
end

def increase_energy_level(grid, y, x)
  return if grid[y][x].nil?

  grid[y][x] += 1
end

def increase_adjacents(grid, y, x)
  (y-1..y+1).each do |y1|
    next if y1 < 0 || y1 >= grid.length

    (x-1..x+1).each do |x1|
      next if x1 < 0 || x1 >= grid.length
      next if y1 == y && x1 == x

      increase_energy_level(grid, y1, x1)
    end
  end
end

def increase_all(grid)
  grid.each_index do |y|
    grid[y].each_index do |x|
      increase_energy_level(grid, y, x)
    end
  end
end

def perform_flashes(grid)
  flashes_count = 0
  while grid.flatten.any? { |energy_level| !energy_level.nil? && energy_level >= 10 }
    grid.each_index do |y|
      grid[y].each_index do |x|
        next if grid[y][x].nil? || grid[y][x] < 10

        increase_adjacents(grid, y, x)
        grid[y][x] = nil
        flashes_count += 1
      end
    end
  end
  flashes_count
end

def reset_flashes_to_zeroes(grid)
  grid.each_index do |y|
    grid[y].each_index do |x|
      grid[y][x] = 0 if grid[y][x].nil?
    end
  end
end

def simulate_step(grid)
  increase_all(grid)
  flashes_count = perform_flashes(grid)
  reset_flashes_to_zeroes(grid)
  flashes_count
end

grid = read_grid
steps = 0
flashes_count = 0
while flashes_count < grid.length * grid[0].length
  flashes_count = simulate_step(grid)
  steps += 1
end
p steps
