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
  puts play.game.comp_board.render_first_row("the CPU")
  puts play.game.comp_board.renders
  puts play.game.user_board.render_first_row("your")
  puts play.game.user_board.renders(true)
  play.game.user_take_turn
  play.game.cpu_take_turn
  play.user_game_status?
  play.cpu_game_status?
end

puts play.game.comp_board.render_first_row("the CPU")
puts play.game.comp_board.renders
puts play.game.user_board.render_first_row("your")
puts play.game.user_board.renders(true)

if play.cpu_game_status.include?("S")
  puts "\n\n     ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~"
  puts "     ~~~~~~GAME OVER! YOU LOSE!~~~~~~"
  puts "     ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~\n\n\n"
end

if play.user_game_status.include?("S")
  puts "\n\n     *******************************"
  puts "     ******GAME OVER! YOU WIN!******"
  puts "     *******************************\n\n\n"
end
