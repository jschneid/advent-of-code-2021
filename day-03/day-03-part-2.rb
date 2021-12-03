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

def calculate_rating(diagnostic_report, common_value_function)
  rating_candidates = diagnostic_report.dup

  (0..diagnostic_report[0].length - 1).each do |position|
    break if rating_candidates.length == 1

    common_value = common_value_function.call(rating_candidates, position)
    rating_candidates = rating_candidates.select { |rating| rating[position] == common_value }
  end

  rating_candidates[0]
end

def calculate_life_support_rating(oxygen_generator_rating, co2_scrubber_rating)
  oxygen_generator_rating.to_i(2) * co2_scrubber_rating.to_i(2)
end

diagnostic_report = read_diagnostic_report
oxygen_generator_rating = calculate_rating(diagnostic_report, method(:most_common_value_at_position))
co2_scrubber_rating = calculate_rating(diagnostic_report, method(:least_common_value_at_position))
p calculate_life_support_rating(oxygen_generator_rating, co2_scrubber_rating)
