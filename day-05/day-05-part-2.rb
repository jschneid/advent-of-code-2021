def read_lines
  File.readlines('input.txt').map(&:chomp)
end

def parse_line(line)
  points = line.split(' -> ')
  point1 = points[0].split(',').map(&:to_i)
  point2 = points[1].split(',').map(&:to_i)

  # Flip the order of the two points if needed, such that point1 is first when sorted by y then by x
  point1, point2 = point2, point1 if point1[1] > point2[1] || (point1[1] == point2[1] && point1[0] > point2[0])

  (point1 + point2)
end

def add_line(grid, x1, y1, x2, y2)
  x = x1
  y = y1
  loop do
    grid[y][x] += 1

    break if x == x2 && y == y2

    y += 1 if y1 < y2
    x += 1 if x1 < x2
    x -= 1 if x2 < x1
  end
end

def add_lines_to_grid(grid, lines)
  lines.each do |line|
    x1, y1, x2, y2 = parse_line(line)
    add_line(grid, x1, y1, x2, y2)
  end
end

def overlapping_points_count(lines)
  grid = Array.new(1000) { Array.new(1000) { 0 } }
  add_lines_to_grid(grid, lines)
  grid.flatten.count { |point| point >= 2 }
end

lines = read_lines
p overlapping_points_count(lines)
