
WIN_COMBINATIONS = [
  [0, 1, 2],
  [3, 4, 5],
  [6, 7, 8],
  [0, 3, 6],
  [1, 4, 7],
  [2, 5, 8],
  [0, 4, 8],
  [2, 4, 6],
]

def display_board(board)
  puts " #{board[0]} | #{board[1]} | #{board[2]} "
  puts "-----------"
  puts " #{board[3]} | #{board[4]} | #{board[5]} "
  puts "-----------"
  puts " #{board[6]} | #{board[7]} | #{board[8]} "
end

def input_to_index(input)
  input.to_i - 1
end

def move(board, index, char)
  board[index] = char
end

def position_taken?(board, index)
  board[index].upcase == "X" || board[index].upcase == "O"
end

def valid_move?(board, index)
  index >= 0 && index < board.length && !position_taken?(board, index)
end

def turn_count(board)
  counter = 0
  board.each do |val|
    if val.upcase == "X" || val.upcase == "O"
      counter += 1
    end
  end
  counter
end

def current_player(board)
  (turn_count(board) % 2) == 0 ? "X" : "O"
end

def won?(board)
  WIN_COMBINATIONS.find do |indexes|
    (board[indexes[0]].upcase == "X" || board[indexes[1]].upcase == "O") && (board[indexes[0]] == board[indexes[1]]) && (board[indexes[0]] == board[indexes[2]])
  end
end

def full?(board)
  board.none? { |val| val.upcase != "X" && val.upcase != "O" }
end

def draw?(board)
  full?(board) && !won?(board)
end

def over?(board)
  won?(board) || draw?(board)
end

def winner(board)
  won = won?(board)
  if won
    board[won[0]]
  end
end

def turn(board)
  index = nil
  loop do
    puts "Please enter 1-9:"
    index = input_to_index(gets.strip)
    if valid_move?(board, index)
      break
    end
  end
  move(board, index, current_player(board))
  display_board(board)
end

def play(board)
  until over?(board)
    turn(board)
  end

  victor = winner(board)
  if victor
    puts "Congratulations #{victor}!"
  elsif puts "Cat's Game!"
  end
end
