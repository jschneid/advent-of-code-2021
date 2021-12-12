class Cave
  attr_reader :id
  attr_reader :exits

  def initialize(id)
    @id = id
    @exits = []
  end

  def add_exit(other_cave)
    @exits << other_cave
  end

  def large?
    @id[0].upcase == @id[0]
  end
end

def find_cave(caves, id)
  caves.find { |cave| cave.id == id }
end

def add_or_find_cave(caves, id)
  cave = find_cave(caves, id)
  caves << cave = Cave.new(id) if cave.nil?
  cave
end

def add_path_between_existing_caves(cave0, cave1)
  cave0.add_exit(cave1)
  cave1.add_exit(cave0)
end

def setup_caves(caves, cave_id0, cave_id1)
  cave0 = add_or_find_cave(caves, cave_id0)
  cave1 = add_or_find_cave(caves, cave_id1)
  add_path_between_existing_caves(cave0, cave1)
end

def read_caves
  input_lines = File.readlines('input.txt').map(&:chomp)

  caves = []

  input_lines.each do |input_line|
    line_caves = input_line.split('-')
    setup_caves(caves, line_caves[0], line_caves[1])
  end

  caves
end

def count_distinct_paths(caves)
  start_cave = find_cave(caves, 'start')
  count_paths_to_end(caves, start_cave, [], false)
end

def count_paths_to_end(caves, cave, visited_list, already_revisited_a_small_cave)
  return 1 if cave.id == 'end'

  visited_list.push(cave)
  paths_to_end_from_here = 0

  cave.exits.each do |next_cave|
    next if next_cave.id == 'start'

    if visited_list.include?(next_cave) && !next_cave.large?
      next if already_revisited_a_small_cave

      paths_to_end_from_here += count_paths_to_end(caves, next_cave, visited_list, true)
    else
      paths_to_end_from_here += count_paths_to_end(caves, next_cave, visited_list, already_revisited_a_small_cave)
    end
  end

  visited_list.pop
  paths_to_end_from_here
end

caves = read_caves
p count_distinct_paths(caves)
