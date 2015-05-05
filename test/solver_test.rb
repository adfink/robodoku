require "minitest"
require "minitest/autorun"
require "./lib/solver"
# require "pride"
# require "./lib/sudoku"

class SolverTest < Minitest::Test

  def setup
    puzzle_text = File.read("./puzzles/easy_sample.txt")
    @solver = Solver.new(puzzle_text)
  end

  def test_it_solves
    skip
    assert false, "make it solve!"
  end

  def test_it_can_output_puzzle_text
    assert_equal 90, @solver.output_data.length
  end

  def test_it_can_split_data
    assert_equal 81, @solver.split_data.count
  end

  def test_it_makes_a_board
    assert_equal 81, @solver.make_board
  end

  def test_it_can_find_peers_for_first_spot
    @solver.make_board
    assert_equal "", @solver.find_peers
  end

  def test


  # validation for solutions --- check row, column, and square
end
