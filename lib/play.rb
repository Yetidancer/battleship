require './lib/game'
class Play

  attr_reader :user_game_status, :cpu_game_status, :game
  def initialize
    @user_game_status = []
    @cpu_game_status = []
    @game = Game.new
  end

  def cpu_game_status?
    @cpu_game_status = []
    # @game.comp_board.cells.keys.each do |key|
    #   @cpu_game_status <<  @game.comp_board.cells[key].render(true)
    # end
    @game.comp_board.cells.values.each do |value|
      @cpu_game_status <<  value.render(true)
    end
    @cpu_game_status
  end

  def user_game_status?
    @user_game_status = []
    @game.user_board.cells.keys.each do |key|
      @user_game_status <<  @game.user_board.cells[key].render(true)
    end
    @user_game_status
  end

end
