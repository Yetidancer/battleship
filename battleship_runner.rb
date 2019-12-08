require './lib/game'

game = Game.new

game.start_game

game.user_input_cruiser_cells
game.user_input_submarine_cells
puts game.comp_board.renders("the CPU")
puts game.user_board.renders("your", true)
turn_1 = Turn.new("A1", game.user_board)
turn_1.take_shot
game.record_shot(turn_1)
require "pry"; binding.pry
