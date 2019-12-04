require 'minitest/autorun'
require 'minitest/pride'
require './lib/ship'
require './lib/cell'
require './lib/board'

class BoardTest < Minitest::Test

  def setup
    @board = Board.new
    # require "pry"; binding.pry
  end

  def test_board_exists
    assert_instance_of Board, @board
  end

  def test_board_is_hash
    assert @board.cells.is_a?(Hash)
  end

  def test_board_has_16_cells
    assert_equal 16, @board.cells.length
  end

  def test_board_hash_keys_to_cells
    assert_instance_of Cell, @board.cells["A1"]
  end

  def test_valid_coordinate?
    assert @board.valid_coordinate?("A1")
    assert @board.valid_coordinate?("D4")
    refute @board.valid_coordinate?("E1")
    refute @board.valid_coordinate?("A22")
  end

  def test_valid_placement
    cruiser = Ship.new("Cruiser", 3)
    submarine = Ship.new("Submarine", 2)

    assert @board.valid_placement?(cruiser, ["A1", "A2", "A3"])
    refute @ibboard.valid_placement?(submarine, ["A1", "A2", "A3"])
  end
end
