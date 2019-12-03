require 'minitest/autorun'
require 'minitest/pride'
require './lib/ship'
require './lib/cell'

class CellTest < Minitest::Test

  def setup
  end

  def test_cell_exists
    cell = Cell.new("B4")

    assert_instance_of Cell, cell
  end
end
