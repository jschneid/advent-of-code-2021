Point = Struct.new :x, :y
Fold = Struct.new :axis, :position

def read_input_lines
  File.readlines('input.txt').map(&:chomp)
end

def build_initial_grid(input_lines)
  grid = []
  input_lines.each do |line|
    return grid if line.empty?

    grid << Point.new(*line.split(',').map(&:to_i))
  end
end

def read_folds(input_lines)
  folds = []
  input_lines.each do |line|
    next unless line.start_with?('fold')

    folds << Fold.new(line[11], line[13..].to_i)
  end
  folds
end

def fold_along_y(grid, y)
  folded_grid = []
  grid.each do |point|
    folded_grid << point if point.y < y
    folded_grid << Point.new(point.x, y - (point.y - y)) if point.y > y
  end
  folded_grid.uniq
end

def fold_along_x(grid, x)
  folded_grid = []
  grid.each do |point|
    folded_grid << point if point.x < x
    folded_grid << Point.new(x - (point.x - x), point.y) if point.x > x
  end
  folded_grid.uniq
end

def perform_fold(grid, fold)
  fold.axis == 'x' ? fold_along_x(grid, fold.position) : fold_along_y(grid, fold.position)
end

def perform_folds(grid, folds)
  folds.each do |fold|
    grid = perform_fold(grid, fold)
  end
  grid
end

def print_grid(grid)
  max_x = grid.map(&:x).max
  max_y = grid.map(&:y).max

  (0..max_y).each do |y|
    line = ''
    (0..max_x).each do |x|
      line += grid.include?(Point.new(x,y)) ? '#' : '.'
    end
    p line
  end

  grid
end

input_lines = read_input_lines
grid = build_initial_grid(input_lines)
folds = read_folds(input_lines)
grid = perform_folds(grid, folds)
print_grid(grid)
