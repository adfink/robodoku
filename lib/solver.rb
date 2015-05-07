require 'pry'
require_relative 'spot'
class Solver

  attr_reader :board
  attr_accessor :final_board

  LETTERMAP = ("a".."i").to_a

  def initialize(puzzle_text)
    @puzzle_text = puzzle_text
    @board = []
    @final_board = {}
  end

  def output_data
    @puzzle_text
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
    return @final_board unless @final_board.empty?

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
    @final_board = board_with_values.inject(Hash.new) do |hash, array|
      hash[array[0]] = array[1]
      hash
    end
  end

  def check_for_empties
    indexes_of_empty_spots = []
    split_data.each_with_index do |char, index|
      if char == " "
        indexes_of_empty_spots << index
      end
    end
    keys_of_empty_spots = indexes_of_empty_spots.map do |index|
      @board[index]
    end
    keys_of_empty_spots
  end

  def solve
    check_for_empties.map do |key_of_spot_to_solve|
      spot = Spot.new(key_of_spot_to_solve, self)
      spot.input_answer
    end
    final_board.values.flatten.each_slice(9) {|line| puts line.join}
  end

end
