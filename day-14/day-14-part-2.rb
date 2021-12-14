def read_polymer_template_and_pair_insertion_rules
  input_lines = File.readlines('input.txt').map(&:chomp)
  pair_insertion_rules = {}

  input_lines.each do |input_line|
    rule = input_line.split(' -> ')
    next unless rule.length == 2

    pair_insertion_rules[rule[0]] = ["#{rule[0][0]}#{rule[1]}", "#{rule[1]}#{rule[0][1]}"]
  end

  [input_lines[0], pair_insertion_rules]
end

# This problem was similar to Day 6 in that brute force was sufficient for
# Part 1, but in Part 2, the exponential time of the brute force solution
# combined with the higher iteration count becomes untenable -- and also
# as in Day 6, a solution is to track the occurrence count of the things we
# care about, without needing to actually track the thing itself.
#
# In this case, each pair insertion results in one pair of elements being
# replaced with two pairs, so we can just track the count of each pair of
# elements.
def template_element_pair_counts(polymer_template)
  element_pair_counts = Hash.new(0)
  (0..(polymer_template.length - 2)).each do |i|
    element_pair = polymer_template[i..(i + 1)]
    element_pair_counts[element_pair] += 1
  end
  element_pair_counts
end

def perform_pair_insertion(element_pair_counts, pair_insertion_rules)
  new_element_pair_counts = Hash.new(0)
  element_pair_counts.each do |element_pair, count|
    new_element_pair_counts[pair_insertion_rules[element_pair][0]] += count
    new_element_pair_counts[pair_insertion_rules[element_pair][1]] += count
  end
  new_element_pair_counts
end

def most_and_least_common_element_counts(element_pair_counts, first_element)
  individual_element_counts = Hash.new(0)
  individual_element_counts[first_element] = 1
  element_pair_counts.each do |element_pair, count|
    individual_element_counts[element_pair[1]] += count
  end

  max_count = individual_element_counts.values.max
  min_count = individual_element_counts.values.min
  [max_count, min_count]
end

polymer_template, pair_insertion_rules = read_polymer_template_and_pair_insertion_rules
element_pair_counts = template_element_pair_counts(polymer_template)
40.times do
  element_pair_counts = perform_pair_insertion(element_pair_counts, pair_insertion_rules)
end
max, min = most_and_least_common_element_counts(element_pair_counts, polymer_template[0])
p max - min
