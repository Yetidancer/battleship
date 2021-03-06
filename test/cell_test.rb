require 'minitest/autorun'
require 'minitest/pride'
require './lib/ship'
require './lib/cell'

class CellTest < Minitest::Test

  def test_cell_exists
    cell = Cell.new("B4")

    assert_instance_of Cell, cell
  end

  def test_cell_coordinate
    cell = Cell.new("B4")

    assert_equal "B4", cell.coordinate
  end

  def test_cell_ship
    cell = Cell.new("B4")

    assert_nil cell.ship
  end

  def test_cell_empty?
    cell = Cell.new("B4")

    assert cell.empty?
  end

  def test_place_ship
    cell = Cell.new("B4")
    cruiser = Ship.new("Cruiser", 3)
    cell.place_ship(cruiser)

    assert_equal cruiser, cell.ship
  end

  def test_cell_not_empty
    cell = Cell.new("B4")
    cruiser = Ship.new("Cruiser", 3)
    cell.place_ship(cruiser)

    refute cell.empty?
  end

  def test_not_fired_upon?
    cell = Cell.new("B4")
    cruiser = Ship.new("Cruiser", 3)
    cell.place_ship(cruiser)

    refute cell.fired_upon?
  end

  def test_fired_upon?
    cell = Cell.new("B4")
    cruiser = Ship.new("Cruiser", 3)
    cell.place_ship(cruiser)

    refute cell.fired_upon?

    cell.fire_upon

    assert_equal 2, cell.ship.health
    assert cell.fired_upon?
  end

  def test_render_period
    cell_1 = Cell.new("B4")

    assert_equal ".", cell_1.render
  end

  def test_render_m_after_fire

    cell_1 = Cell.new("B4")
    assert_equal ".", cell_1.render

    yes = cell_1.fire_upon
    assert_equal "M", cell_1.render
  end

  def test_render_s_for_boolean
    cell_2 = Cell.new("C3")
    cruiser = Ship.new("Cruiser", 3)
    cell_2.place_ship(cruiser)

    assert_equal ".", cell_2.render
    assert_equal "S", cell_2.render(true)
  end

  def test_render_h_when_unsunk
    cell_2 = Cell.new("C3")
    cruiser = Ship.new("Cruiser", 3)
    cell_2.place_ship(cruiser)
    cell_2.fire_upon

    assert_equal "H", cell_2.render
  end

  def test_render_x_when_sunk
    cell_2 = Cell.new("C3")
    cruiser = Ship.new("Cruiser", 3)
    cell_2.place_ship(cruiser)
    cell_2.fire_upon

    cruiser.sunk?
    cruiser.hit
    cruiser.hit
    cruiser.sunk?

    assert_equal "X", cell_2.render
  end
end
