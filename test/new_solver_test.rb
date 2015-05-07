require "minitest"
require "minitest/autorun"
require "./lib/new_solver"
# require "pride"
# require "./lib/sudoku"

class SolverTest < Minitest::Test

  def setup
    puzzle_text = File.read("./puzzles/easy_sample.txt")
    @solver = Solver.new(puzzle_text)
  end

  def test_it_can_output_puzzle_text
    assert_equal 90, @solver.output_data.length
  end

  def test_it_can_split_data
    assert_equal 81, @solver.split_data.size
  end

  def test_it_can_make_squares_array
    assert_equal 81, @solver.squares.size
  end

  def test_it_makes_a_board
    assert_equal 81, @solver.make_board.values.count
  end

  def test_a_board_can_know_which_spots_it_needs_to_solve
    @solver.make_board
    assert_equal ["a1z"], @solver.check_for_empties
  end

  def test_a_board_can_solve_easy_problems
    @solver.make_board
    assert_equal " ", @solver.final_board["a1z"]
    @solver.solve
    assert_equal "8", @solver.final_board["a1z"]
  end

end
