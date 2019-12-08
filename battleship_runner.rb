require './lib/game'

game = Game.new
board = Board.new

game.start_game
game.user_input_cruiser_cells
game.user_input_submarine_cells
