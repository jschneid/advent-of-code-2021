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

def risk_level_total(heightmap)
  total = 0
  heightmap.each_index do |y|
    heightmap[0].each_index do |x|
      total += heightmap[y][x] + 1 if low_point?(heightmap, y, x)
    end
  end
  total
end

heightmap = read_heightmap
p risk_level_total(heightmap)
