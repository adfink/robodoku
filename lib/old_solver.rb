require 'pry'


class Solver

  attr_reader :board

  LETTERMAP = ("a".."i").to_a

  def initialize(puzzle_text)
    @puzzle_text = puzzle_text
    @board = []
    @possible_values = ["8", "7", "3", "1", "9", "2", "5", "4", "6"]
  end


  def split_data
    @puzzle_text.split("\n").map(&:chars).flatten
  end


  def squares
    first = ["z","w","t"]
    second = ["y","v","s"]
    third = ["x","u","r"]
    squares = []
      3.times do
          3.times do
            squares << [first[0], first[0], first[0]];
            squares << [second[0], second[0], second[0]];
            squares << [third[0], third[0], third[0]];
          end
        first.rotate!
        second.rotate!
        third.rotate!
      end
    squares.flatten
  end


  def make_board
    letters = ("a".."i").to_a
    row = ["x", "x", "x", "x", "x", "x", "x", "x", "x"]
    letters_to_sub = letters.zip(row).map(&:join)
    positions = []
    9.times do |time|
      positions << letters_to_sub.map do |pair|
        pair.gsub('x', (time+1).to_s)
      end
    end
    final_positions = positions.flatten.zip(squares).map(&:join)
    @board = final_positions
    board_with_values = final_positions.zip(split_data)
    final_board = board_with_values.inject(Hash.new) do |hash, array|
      hash[array[0]] = array[1]
      hash
    end
    final_board
  end


  def output_data
    @puzzle_text
  end


  def find_peers_keys
    @board.inject(Hash.new) do |hash, spot|
        column = spot[0]
        row = spot[1]
        square = spot[2]

        column_peers = @board.select do |spot|
          spot[0] == column
        end
        row_peers = @board.select do |spot|
          spot[1] == row
        end
        square_peers = @board.select do |spot|
          spot[2] == square
        end
      keys_of_peers_for_spot = column_peers + row_peers + square_peers
      hash[spot] = keys_of_peers_for_spot.uniq
      hash
    end
  end


  def find_values_of_peers
    @board.inject(Hash.new) do |hash, spot|
      peers_keys_array = find_peers_keys[spot]
      hash[spot] =  peers_keys_array.map{|peer_key| make_board[peer_key]}.uniq
      hash
    end
  end

  def check_for_easy_solution
    indexes_of_empty_spots = []
    @puzzle_text.chars.each_with_index do |char, index|
      if char == " "
      indexes_of_empty_spots << index
      end
    end

    keys_of_empty_spots = indexes_of_empty_spots.map do |index|
      @board[index]
    end

    keys_of_empty_spots.map do |key|
      peer_values = find_values_of_peers[key]
      possible_solution = @possible_values.map do |value|
          if peer_values.include?(value)
            value = nil
          else
            value
          end
      end.compact
      possible_solution
    end.flatten
  end
end

  # parse into row, column, square

  # coordinate system with a hash.... A1, A2, A3... to map a board

  # know the value of a spot and/or if a spot is blank or not
  # know where each spot is on the board
  # find all of a spot's peers...
  # check to see if there is an easy solution
  # if not move on to check next open spot




























#
# def make_board
#   letters = ("a".."i").to_a
#   numbers = (1..9).to_a
#   board = []
#   index_counter = 0
#   9.times do
#     x = letters[index_counter]
#     index_counter += 1
#     row = [x,x,x,x,x,x,x,x,x]
#     row.zip(numbers)
#     board << row
#   end
#   p board
# end
