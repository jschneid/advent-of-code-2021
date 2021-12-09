def read_heightmap
  File.readlines('input.txt').map(&:chomp).map(&:chars).map { |row| row.map(&:to_i) }
end

def low_point?(heightmap, y, x)
  return false if y > 0 && heightmap[y-1][x] <= heightmap[y][x]
  return false if x > 0 && heightmap[y][x-1] <= heightmap[y][x]
  return false if y < heightmap.length - 1 && heightmap[y+1][x] <= heightmap[y][x]
  return false if x < heightmap[0].length - 1 && heightmap[y][x+1] <= heightmap[y][x]
  true
end

def find_lowest_points(heightmap)
  lowest_points = []
  heightmap.each_index do |y|
    heightmap[0].each_index do |x|
      lowest_points << { y: y, x: x } if low_point?(heightmap, y, x)
    end
  end
  lowest_points
end

def find_basin_sizes!(heightmap, lowest_points)
  lowest_points.each do |low_point|
    low_point[:basin_size] = basin_size(heightmap, low_point[:y], low_point[:x])
  end
end

def basin_size(heightmap, y, x)
  return 0 if y < 0 || x < 0 || y >= heightmap.length || x >= heightmap[0].length
  return 0 if heightmap[y][x] == 9

  # A bit of a hack here, but an expedient way to avoid having this recursive method
  # consider this point again in a subsequent call is to mutate the heightmap to set
  # this location's height to 9.
  heightmap[y][x] = 9

  1 + basin_size(heightmap, y - 1, x) + basin_size(heightmap, y, x - 1) + basin_size(heightmap, y + 1, x) + basin_size(heightmap, y, x + 1)
end

heightmap = read_heightmap
lowest_points = find_lowest_points(heightmap)
find_basin_sizes!(heightmap, lowest_points)
lowest_points.sort_by! { |point| point[:basin_size] }
p lowest_points.last(3).map { |point| point[:basin_size] }.reduce(:*)
