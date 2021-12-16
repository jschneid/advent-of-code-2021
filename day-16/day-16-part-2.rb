@index = 0
@version_numbers_total = 0

def read_transmission_binary
  hex = File.readlines('input.txt')[0].chomp
  @transmission = hex.to_i(16).to_s(2).rjust(4 * hex.length, '0')
end

def read_version
  @transmission[@index...(@index += 3)].to_i(2)
end

def read_type_id
  @transmission[@index...(@index += 3)].to_i(2)
end

def read_length_type_id
  @transmission[@index...(@index += 1)].to_i(2)
end

def read_literal_value
  packet_length = 6
  literal_bits = ''
  loop do
    group = @transmission[@index...(@index += 5)]
    packet_length += 5
    literal_bits += group[1..4]
    break if group[0] == '0'
  end

  literal_bits.to_i(2)
end

def read_type_0_sub_packets_length
  @transmission[@index...(@index += 15)].to_i(2)
end

def read_length_type_0_sub_packets
  sub_packets_length = read_type_0_sub_packets_length
  sub_packets_start_index = @index
  sub_packet_values = []

  sub_packet_values << read_packet while @index < sub_packets_start_index + sub_packets_length

  sub_packet_values
end

def read_length_type_1_sub_packets_count
  @transmission[@index...(@index += 11)].to_i(2)
end

def read_length_type_1_sub_packets
  sub_packet_values = []

  read_length_type_1_sub_packets_count.times { sub_packet_values << read_packet }

  sub_packet_values
end

def read_packet
  read_version
  type_id = read_type_id

  result = nil
  if type_id == 4
    result = read_literal_value
  else
    length_type_id = read_length_type_id
    sub_packet_values = if length_type_id.zero?
                          read_length_type_0_sub_packets
                        else
                          read_length_type_1_sub_packets
                        end

    case type_id
    when 0
      result = sub_packet_values.sum
    when 1
      result = sub_packet_values.reduce(:*)
    when 2
      result = sub_packet_values.min
    when 3
      result = sub_packet_values.max
    when 5
      result = sub_packet_values[0] > sub_packet_values[1] ? 1 : 0
    when 6
      result = sub_packet_values[0] < sub_packet_values[1] ? 1 : 0
    when 7
      result = sub_packet_values[0] == sub_packet_values[1] ? 1 : 0
    end
  end

  result
end

read_transmission_binary
p read_packet
