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

  def test_valid_placement_length
    cruiser = Ship.new("Cruiser", 3)
    submarine = Ship.new("Submarine", 2)

    assert @board.valid_placement?(cruiser, ["A1", "A2", "A3"])
    refute @ibboard.valid_placement?(submarine, ["A1", "A2", "A3"])
  end

  def test_valid_placement_consecutive
#this one will be difficult
#my idea is to grab the proposed array
#split the cell coordinate into letter and number
#then change the letter into its associated ASCII number
#using this, you have to compare consecutive cells in the proposed valid_placement array and make sure that the letter is the same AND the number is one away OR the letter is one away from the next AND that the number is the same

#ANOTHER OPTION

#come up with the 24 associations, ie A1 and A2, B3 and C3, D3 and D4 
  end
end
