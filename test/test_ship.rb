#this is a test
require 'minitest/autorun'
require 'minitest/pride'
require './lib/ship'

class ShipTest < Minitest::Test

  def setup
    @cruiser = Ship.new("Cruiser", 3)
  end

  def test_ship_exists
    # require "pry"; binding.pry
    assert_instance_of Ship, @cruiser
  end

  def test_attributes
    assert_equal "Cruiser", @cruiser.name
    assert_equal 3, @cruiser.length
    assert_equal 3, @cruiser.health
  end

  def test_sunk?
    refute @cruiser.sunk?
  end

  def test_hit
    @cruiser.hit

    assert_equal 2, @cruiser.health

    # require "pry"; binding.pry

    @cruiser.hit

    assert_equal 1, @cruiser.health

    @cruiser.hit

    assert_equal 0, @cruiser.health
  end

  def test_fully_sunk?
    3.times do
      @cruiser.hit
    end 
    assert @cruiser.sunk?
  end
end
