def read_diagnostic_report
  File.readlines('input.txt').map(&:chomp)
end

def calculate_gamma_rate(diagnostic_report)
  report_entry_length = diagnostic_report[0].length
  gamma_rate_string = ''
  (0..report_entry_length - 1).each do |i|
    zeroes = 0
    diagnostic_report.each { |report_line| zeroes += 1 if report_line[i] == '0' }

    gamma_rate_string += zeroes > diagnostic_report.length / 2 ? '0' : '1'
  end

  gamma_rate_string.to_i(2)
end

def calculate_epsilon_rate(gamma_rate, report_entry_length)
  gamma_rate ^ ('1' * report_entry_length).to_i(2)
end

diagnostic_report = read_diagnostic_report
gamma_rate = calculate_gamma_rate(diagnostic_report)
epsilon_rate = calculate_epsilon_rate(gamma_rate, diagnostic_report[0].length)

p gamma_rate * epsilon_rate
