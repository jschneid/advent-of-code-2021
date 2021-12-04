def read_draws(input_lines)
  input_lines[0].split(',').map(&:to_i)
end

def read_boards(input_lines)
  boards = []
  line_index = 2
  while line_index < input_lines.length
    board = []
    5.times do
      board << input_lines[line_index].split(' ').map(&:to_i)
      line_index += 1
    end
    boards << board
    line_index += 1
  end
  boards
end

def bingo_row?(board, marks)
  board.each do |board_row|
    return true if (board_row - marks).empty?
  end
  false
end

def bingo_column?(board, marks)
  (0..4).each do |column_index|
    board_column = []
    (0..4).each do |row_index|
      board_column << board[row_index][column_index]
    end
    return true if (board_column - marks).empty?
  end
  false
end

def unmarked_numbers_sum_if_has_bingo(board, marks)
  return (board.flatten - marks).sum if bingo_row?(board, marks) || bingo_column?(board, marks)

  nil
end

def final_score_if_has_bingo(board, marks, draw)
  bingo_sum = unmarked_numbers_sum_if_has_bingo(board, marks)
  return nil if bingo_sum.nil?

  bingo_sum * draw
end

def play_bingo(draws, boards)
  marks = []
  draws.each do |draw|
    marks << draw
    boards.each do |board|
      winning_score = final_score_if_has_bingo(board, marks, draw)
      return winning_score unless winning_score.nil?
    end
  end
end

input_lines = File.readlines('input.txt').map(&:chomp)
draws = read_draws(input_lines)
boards = read_boards(input_lines)
p play_bingo(draws, boards)
