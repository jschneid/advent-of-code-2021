def read_lines
  File.readlines('input.txt').map(&:chomp)
end

def parse_line(line)
  points = line.split(' -> ')
  point1 = points[0].split(',')
  point2 = points[1].split(',')
  (point1 + point2).map(&:to_i)
end

def add_horizontal_line(grid, x1, x2, y)
  x1, x2 = x2, x1 if x1 > x2
  (x1..x2).each do |x|
    grid[y][x] += 1
  end
end

def add_vertical_line(grid, x, y1, y2)
  y1, y2 = y2, y1 if y1 > y2
  (y1..y2).each do |y|
    grid[y][x] += 1
  end
end

def add_lines_to_grid(grid, lines)
  lines.each do |line|
    x1, y1, x2, y2 = parse_line(line)
    add_horizontal_line(grid, x1, x2, y1) if y1 == y2
    add_vertical_line(grid, x1, y1, y2) if x1 == x2
  end
end

def overlapping_points_count(lines)
  grid = Array.new(1000) { Array.new(1000) { 0 } }
  add_lines_to_grid(grid, lines)
  grid.flatten.count { |point| point >= 2 }
end

lines = read_lines
p overlapping_points_count(lines)
