def read_diagnostic_report
  File.readlines('input.txt').map(&:chomp)
end

def most_common_value_at_position(diagnostic_report_records, position)
  zeroes = 0
  ones = 0

  diagnostic_report_records.each do |report_line|
    if report_line[position] == '0'
      zeroes += 1
    else
      ones += 1
    end
  end

  ones >= zeroes ? '1' : '0'
end

def least_common_value_at_position(diagnostic_report_records, position)
  most_common_value_at_position(diagnostic_report_records, position) == '0' ? '1' : '0'
end

def calculate_oxygen_generator_rating(diagnostic_report)
  possible_oxygen_generator_ratings = diagnostic_report.dup

  (0..diagnostic_report[0].length - 1).each do |position|
    break if possible_oxygen_generator_ratings.length == 1

    common_value = most_common_value_at_position(possible_oxygen_generator_ratings, position)
    possible_oxygen_generator_ratings = possible_oxygen_generator_ratings.select { |rating| rating[position] == common_value }
  end

  possible_oxygen_generator_ratings[0]
end

def calculate_co2_scrubber_rating(diagnostic_report)
  possible_co2_scrubber_ratings = diagnostic_report.dup

  (0..diagnostic_report[0].length - 1).each do |position|
    break if possible_co2_scrubber_ratings.length == 1

    least_common_value = least_common_value_at_position(possible_co2_scrubber_ratings, position)
    possible_co2_scrubber_ratings = possible_co2_scrubber_ratings.select { |rating| rating[position] == least_common_value }
  end

  possible_co2_scrubber_ratings[0]
end

def calculate_life_support_rating(oxygen_generator_rating, co2_scrubber_rating)
  oxygen_generator_rating.to_i(2) * co2_scrubber_rating.to_i(2)
end

diagnostic_report = read_diagnostic_report
oxygen_generator_rating = calculate_oxygen_generator_rating(diagnostic_report)
co2_scrubber_rating = calculate_co2_scrubber_rating(diagnostic_report)
p calculate_life_support_rating(oxygen_generator_rating, co2_scrubber_rating)
