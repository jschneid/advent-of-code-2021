def line_score(line)
  stack = []
  line.chars.each do |c|
    if ['(', '[', '{', '<'].include?(c)
      stack.push(c)
    else
      last_open = stack.pop
      case c
      when ')'
        return 3 if last_open != '('
      when ']'
        return 57 if last_open != '['
      when '}'
        return 1197 if last_open != '{'
      when '>'
        return 25137 if last_open != '<'
      end
    end
  end
  0
end

def lines_score(lines)
  score = 0
  lines.each do |line|
    score += line_score(line)
  end
  score
end

lines = File.readlines('input.txt').map(&:chomp)
p lines_score(lines)
