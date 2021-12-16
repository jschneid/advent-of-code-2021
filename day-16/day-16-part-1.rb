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

def read_type_0_sub_packets
  sub_packets_length = read_type_0_sub_packets_length
  sub_packets_start_index = @index
  read_packet while @index < sub_packets_start_index + sub_packets_length
end

def read_type_1_sub_packets_count
  @transmission[@index...(@index += 11)].to_i(2)
end

def read_type_1_sub_packets
  read_type_1_sub_packets_count.times { read_packet }
end

def read_packet
  @version_numbers_total += read_version
  type_id = read_type_id

  if type_id == 4
    _literal = read_literal_value
  else
    length_type_id = read_length_type_id
    if length_type_id.zero?
      read_type_0_sub_packets
    else
      read_type_1_sub_packets
    end
  end
end

read_transmission_binary
read_packet
p @version_numbers_total
