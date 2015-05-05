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
    skip
    assert_equal 81, @solver.split_data.count
  end

  def test_it_makes_a_board
    skip
    assert_equal 81, @solver.make_board
  end

  def test_it_can_find_peers_for_each_spot
    skip
    @solver.make_board
    assert_equal "", @solver.find_peers_keys
  end

    def test_it_can_find_values_of_peers
      skip
      @solver.make_board
      @solver.find_peers_keys
      assert_equal "", @solver.find_values_of_peers
    end

  def test_it_can_find_easy_solution
    @solver.make_board
    @solver.find_peers_keys
    @solver.find_values_of_peers
    assert_equal "", @solver.check_for_easy_solution
  end


  # validation for solutions --- check row, column, and square
end
