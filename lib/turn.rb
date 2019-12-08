class Turn

  attr_reader :shot, :board
  def initialize(shot, board)
    @shot = shot
    @board = board

  end

  def take_shot
    @board.cells[@shot].fire_upon
  end

end
