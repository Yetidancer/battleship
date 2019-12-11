require 'minitest/autorun'
require 'minitest/pride'
require './lib/ship'
require './lib/cell'
require './lib/board'

class BoardTest < Minitest::Test

  def setup
    @board = Board.new
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

    assert @board.valid_placement_length?(cruiser, ["A1", "A2", "A3"])
    refute @board.valid_placement_length?(submarine, ["A1", "A2", "A3"])
  end

  def test_valid_placement_consecutive
  submarine = Ship.new("Submarine", 2)
  assert @board.valid_placement_consecutive?(submarine, ["A1","B1"])

  cruiser = Ship.new("Cruiser", 3)
  assert @board.valid_placement_consecutive?(cruiser, ["A1","A2","A3"])
  end

  def test_board_places_ship
    cruiser = Ship.new("Cruiser", 3)
    @board.place(cruiser, ["A1", "A2", "A3"])
    cell_1 = @board.cells["A1"]
    cell_2 = @board.cells["A2"]
    cell_3 = @board.cells["A3"]

    assert_equal cruiser, cell_1.ship
    assert_equal cruiser, cell_2.ship
    assert_equal cruiser, cell_3.ship
    assert cell_3.ship == cell_2.ship
  end

  def test_board_no_overlap
    cruiser = Ship.new("Cruiser", 3)
    @board.place(cruiser, ["A1", "A2", "A3"])
    submarine = Ship.new("Submarine", 2)

    refute @board.valid_placement_no_overlap?(submarine, ["A1", "B1"])
  end

  def test_renders
    submarine = Ship.new("Submarine", 2)
    cruiser = Ship.new("Cruiser", 3)
    @board.place(submarine, ["A1","A2"])
    @board.cells["A1"].fire_upon
    @board.cells["A2"].fire_upon
    @board.cells["B2"].fire_upon
    @board.cells["C4"].fire_upon
    @board.place(cruiser, ["B4","C4","D4"])
    assert_equal ("A  X  X  .  .  \n" + "B  .  M  .  .  \n" + "C  .  .  .  H  \n" + "D  .  .  .  .  \n" + "-------------"), @board.renders
    ("A  X  X  .  .  \n" + "B  .  M  .  S  \n" + "C  .  .  .  H  \n" + "D  .  .  .  S  \n" + "-------------")
    assert_equal ("A  X  X  .  .  \n" + "B  .  M  .  S  \n" + "C  .  .  .  H  \n" + "D  .  .  .  S  \n" + "-------------"), @board.renders(true)
  end
end
