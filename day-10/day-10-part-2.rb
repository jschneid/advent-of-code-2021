def corrupt?(line)
  stack = []
  line.chars.each do |c|
    if ['(', '[', '{', '<'].include?(c)
      stack.push(c)
    else
      last_open = stack.pop
      case c
      when ')'
        return true if last_open != '('
      when ']'
        return true if last_open != '['
      when '}'
        return true if last_open != '{'
      when '>'
        return true if last_open != '<'
      end
    end
  end
  false
end

def find_uncorrupted_lines(lines)
  uncorrupted_lines = []
  lines.each do |line|
    uncorrupted_lines << line unless corrupt?(line)
  end
  uncorrupted_lines
end

def completed_line_score(line)
  stack = []
  line.chars.each do |c|
    if ['(', '[', '{', '<'].include?(c)
      stack.push(c)
    else
      stack.pop
    end
  end

  score = 0
  stack.reverse_each do |c|
    case c
    when '('
      score = score * 5 + 1
    when '['
      score = score * 5 + 2
    when '{'
      score = score * 5 + 3
    when '<'
      score = score * 5 + 4
    end
  end
  score
end

def median_completed_lines_score(lines)
  scores = []
  lines.each do |line|
    scores << completed_line_score(line)
  end
  scores.sort![scores.length / 2]
end

lines = File.readlines('input.txt').map(&:chomp)
uncorrupted_lines = find_uncorrupted_lines(lines)
p median_completed_lines_score(uncorrupted_lines)
