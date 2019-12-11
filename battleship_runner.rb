require './lib/game'
require './lib/play'

play = Play.new

play.game.start_game
play.game.user_board.set_board_size
play.game.set_comp_board_size
play.game.user_input_first_ship
play.game.user_input_other_ships
play.user_game_status?
play.cpu_game_status?
while play.user_game_status.include?("S") && play.cpu_game_status.include?("S")
  play.game.comp_board.render_first_row("the CPU")
  play.game.comp_board.renders
  play.game.user_board.render_first_row("your")
  play.game.user_board.renders(true)
  play.game.cpu_take_turn
  play.game.user_take_turn
  play.user_game_status?
  play.cpu_game_status?
end

play.game.comp_board.render_first_row("the CPU")
play.game.comp_board.renders
play.game.user_board.render_first_row("your")
play.game.user_board.renders(true)

if play.cpu_game_status.include?("S")
  puts "GAME OVER! YOU LOSE!"
end

if play.user_game_status.include?("S")
  puts "GAME OVER! YOU WIN!"
end
