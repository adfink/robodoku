require "minitest"
require "minitest/autorun"
require "./lib/spot"
require "./lib/solver"
# require "pride"
# require "./lib/sudoku"

class SpotTest < Minitest::Test

  def setup
    puzzle_text = File.read("./puzzles/easy_sample.txt")
    @solver = Solver.new(puzzle_text)
    @solver.make_board
    @spot = Spot.new(@solver.board[0], @solver)

  end

  def test_that_a_spot_exists
    spot = Spot.new(@solver.board[0], @solver)
  end

  def test_that_a_spot_can_output_its_position
    spot = @spot
    assert_equal "a1z", spot.position
    assert_equal "a", spot.column
    assert_equal "1", spot.row
    assert_equal "z", spot.square
  end

  def test_a_spot_can_find_its_peer_spots
    assert_equal 21, @spot.find_peer_spots.size
  end

  def test_a_spot_can_find_its_peers_values
    assert_equal 9, @spot.find_values_of_peers.size
  end

  def test_a_spot_can_check_for_an_easy_solution
    assert_equal ["8"], @spot.check_for_possibilities
  end

  def test_a_spot_can_assign_the_correct_answer_to_its_value_in_board_hash
    @spot.check_for_possibilities
    @spot.input_answer
    assert_equal "8", @solver.final_board[@spot.position]
  end

end
