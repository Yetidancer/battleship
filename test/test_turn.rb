require 'minitest/autorun'
require 'minitest/pride'
require './lib/ship'
require './lib/cell'
require './lib/board'
require './lib/game'
require './lib/turn'

class TurnTest < MiniTest::Test

  def setup
    @board_1 = Board.new
    @turn_1 = Turn.new("A1", @board_1)
  end

  def test_it_exists

    assert_instance_of Turn, Turn.new("A1", Board.new)
  end

  def test_attributes_exists
    assert_equal "A1", @turn_1.shot
    assert_equal @board_1, @turn_1.board
  end

  def test_shot_is_recorded
    @board_1.set_board_size
    @turn_1.take_shot
    assert @board_1.cells["A1"].fired_upon?
  end

  def test_

  end

end
