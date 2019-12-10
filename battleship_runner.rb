require './lib/game'
require './lib/play'

play = Play.new

play.game.start_game
play.game.user_board.set_board_size
play.game.set_comp_board_size
# require "pry"; binding.pry
play.game.user_input_cruiser_cells
play.game.user_input_submarine_cells
play.user_game_status?
play.cpu_game_status?
require "pry"; binding.pry
while play.user_game_status.include?("S") && play.cpu_game_status.include?("S")
  play.game.comp_board.render_first_row("the CPU")
  play.game.user_board.render_first_row("your")
  play.game.comp_board.renders
  play.game.user_board.renders(true)
  play.game.cpu_take_turn
  play.game.user_take_turn
  play.user_game_status?
  play.cpu_game_status?
end

puts play.game.comp_board.renders("the CPU")
puts play.game.user_board.renders("your", true)

if play.cpu_game_status.include?("S")
  puts "GAME OVER! YOU LOSE!"
end

if play.user_game_status.include?("S")
  puts "GAME OVER! YOU WIN!"
end
