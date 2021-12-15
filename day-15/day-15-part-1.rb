require 'set'

Point = Struct.new :y, :x
Node = Struct.new :point, :cost

def read_grid
  File.readlines('input.txt').map(&:chomp).map(&:chars).map { |row| row.map(&:to_i) }
end

def should_visit(point, evaluated_points, grid)
  return false if point.y < 0
  return false if point.x < 0
  return false if point.y >= grid.length
  return false if point.x >= grid[0].length
  return false if evaluated_points.include? (point)

  true
end

def neighbors(point)
  [Point.new(point.y + 1, point.x), Point.new(point.y, point.x + 1), Point.new(point.y - 1, point.x), Point.new(point.y, point.x - 1)]
end

# An implementation of Dijkstra’s shortest path algorithm for our grid.
#
# At any given time, elements of possible_solution_paths are the locations
# on our grid and the cost to get there, sorted by cheapest first.
#
# On each loop iteration, we explore outward from whatever the cheapest-
# cost point is.
#
# When we reach the bottom-right corner of the grid, we're done.
#
# Blog post that inspired this approach:
# https://levelup.gitconnected.com/dijkstras-shortest-path-algorithm-in-a-grid-eb505eb3a290
def lowest_risk_path(grid)
  possible_solution_paths = [Node.new(Point.new(0, 0), 0)]
  evaluated_points = Set.new(possible_solution_paths.first.point)

  loop do
    here = possible_solution_paths.first

    return here.cost if here.point.y == grid.length - 1 && here.point.x == grid[0].length - 1

    neighbors(here.point).each do |neighbor|
      if should_visit(neighbor, evaluated_points, grid)
        evaluated_points.add(neighbor)
        possible_solution_paths << Node.new(neighbor, here.cost + grid[neighbor.y][neighbor.x])
      end
    end

    # Now that we're done mapping out the neighbors of the element at "here", remove it.
    possible_solution_paths.shift

    possible_solution_paths.sort_by!(&:cost)
  end

  possible_solution_paths
end

grid = read_grid
pp lowest_risk_path(grid)
