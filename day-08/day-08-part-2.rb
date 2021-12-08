def read_signal_patterns_and_outputs
  input_lines = File.readlines('input.txt').map(&:chomp)
  split_input_lines = input_lines.map { |line| line.split('|') }
  signal_patterns_list = split_input_lines.map { |split_line| split_line[0].split(' ') }
  output_values_list = split_input_lines.map { |split_line| split_line[1].split(' ') }

  # Alphabetically sort each value, to make comparisons that we do later easier
  signal_patterns_list.map! { |signal_patterns| signal_patterns.map { |signal| signal.chars.sort.join } }
  output_values_list.map! { |output_values| output_values.map { |value| value.chars.sort.join } }

  [signal_patterns_list, output_values_list]
end

# Count of digital display segments for each digit:
# 2 segments: 1
# 3 segments: 7
# 4 segments: 4
# 5 segments: 2, 3, 5
# 6 segments: 0, 6, 9
# 7 segments: 8
def deduce_digit_patterns(signal_patterns)
  digit_patterns = []

  # Day 8 Part 1 demonstrated that the digits 1, 4, 7, and 8 can easily be
  # identified from their unique count of segments in the display.
  digit_patterns[1] = signal_patterns.find { |pattern| pattern.length == 2 }
  digit_patterns[4] = signal_patterns.find { |pattern| pattern.length == 4 }
  digit_patterns[7] = signal_patterns.find { |pattern| pattern.length == 3 }
  digit_patterns[8] = signal_patterns.find { |pattern| pattern.length == 7 }

  # Each of the remaining digits can be deduced either by combining the above
  # "count of segments" approach with:
  #
  # (1) Finding the pattern which, when the segments in one of the
  # already-identified patterns is subtracted ("turned off"), corresponds
  # to only one of the remaining digits with that pattern's segment count.
  # For example, if the segments in digit "1" are subtracted from the
  # segments in the 6-character digits, only the digit "6" has 5 remaining
  # lit segments;
  #
  # (2) Process of elimination: When we've already identified the patterns
  # for digits "6" and "9", then the pattern with 6 segments that isn't
  # equal to one of those must be the only remaining 6-segment digit: "0".
  digit_patterns[6] = signal_patterns.find { |pattern| pattern.length == 6 && (pattern.chars - digit_patterns[1].chars).length == 5 }
  digit_patterns[9] = signal_patterns.find { |pattern| pattern.length == 6 && (pattern.chars - digit_patterns[4].chars).length == 2 }
  digit_patterns[0] = signal_patterns.find { |pattern| pattern.length == 6 && pattern != digit_patterns[6] && pattern != digit_patterns[9] }
  digit_patterns[2] = signal_patterns.find { |pattern| pattern.length == 5 && (pattern.chars - digit_patterns[9].chars).length == 1 }
  digit_patterns[3] = signal_patterns.find { |pattern| pattern.length == 5 && (pattern.chars - digit_patterns[1].chars).length == 3 }
  digit_patterns[5] = signal_patterns.find { |pattern| pattern.length == 5 && pattern != digit_patterns[2] && pattern != digit_patterns[3] }

  digit_patterns
end

def decode_output_digits(output_values, digit_patterns)
  output_values.map { |value| digit_patterns.find_index(value) }.join.to_i
end

signal_patterns_list, output_values_list = read_signal_patterns_and_outputs

output_values_sum = 0
signal_patterns_list.each_index do |i|
  digit_patterns = deduce_digit_patterns(signal_patterns_list[i])
  output_values_sum += decode_output_digits(output_values_list[i], digit_patterns)
end

p output_values_sum
