def read_polymer_template_and_pair_insertion_rules
  input_lines = File.readlines('input.txt').map(&:chomp)
  pair_insertion_rules = {}

  input_lines.each do |input_line|
    rule = input_line.split(' -> ')
    next unless rule.length == 2

    pair_insertion_rules[rule[0]] = "#{rule[0][0]}#{rule[1]}#{rule[0][1]}"
  end

  [input_lines[0], pair_insertion_rules]
end

def perform_pair_insertion(polymer, pair_insertion_rules)
  new_polymer = polymer[0]
  (0..polymer.length - 2).each do |i|
    new_polymer += pair_insertion_rules["#{polymer[i]}#{polymer[i + 1]}"][1..]
  end
  new_polymer
end

def most_and_least_common_element_counts(polymer)
  elements = polymer.chars.uniq
  counts = {}
  elements.each do |element|
    counts[element] = polymer.count(element)
  end
  max_count = counts.values.max
  min_count = counts.values.min
  [max_count, min_count]
end

polymer, pair_insertion_rules = read_polymer_template_and_pair_insertion_rules
10.times do
  polymer = perform_pair_insertion(polymer, pair_insertion_rules)
end
max, min = most_and_least_common_element_counts(polymer)
p max - min
