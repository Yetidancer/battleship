require 'minitest/autorun'
require 'minitest/pride'
require './lib/ship'
require './lib/cell'

class CellTest < Minitest::Test

  def setup
    @cell = Cell.new("B4")
  end

  def test_cell_exists

    assert_instance_of Cell, @cell
  end

  def test_cell_coordinate

    assert_equal "B4", @cell.coordinate
  end

  def test_cell_ship

    assert_equal nil, @cell.ship
  end

  def test_cell_empty?

    assert @cell.empty?
  end

end
