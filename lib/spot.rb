require_relative 'solver'
require 'pry'

class Spot

  attr_reader :position, :column, :row, :square, :board, :board_with_values, :possible_values

  def initialize(position, solver)
    @position = position
    @column   = position[0]
    @row      = position[1]
    @square   = position[2]
    @board    = solver.board
    @board_with_values = solver.make_board
    @possible_values = ["1", "2", "3", "4", "5", "6", "7", "8", "9"]
  end

  def find_peer_spots
      column_peers = board.select do |spot|
        spot[0] == column
      end
      row_peers = board.select do |spot|
        spot[1] == row
      end
      square_peers = board.select do |spot|
        spot[2] == square
      end
     peer_spot_keys =  column_peers + row_peers + square_peers
     peer_spot_keys.uniq  #right now these peer keys include self, include the current spot's position as well..... maybe don't want this
  end


  def find_values_of_peers
    find_peer_spots.map do |peer_key|
      board_with_values[peer_key]
    end.uniq
  end

  def check_for_possibilities
    possible_values.map do |char|
      find_values_of_peers.include?(char) ? char = nil : char
      end.compact
  end

  def answer?
    check_for_possibilities.size == 1
  end

  def input_answer
    if answer?
      @board_with_values[position] = check_for_possibilities[0]
    else
      # binding.pry
      raise RuntimeError, "shoot something didn't go right...it seems as though the row is 8 when it should be 7. don't know why"
    end
  end

end
