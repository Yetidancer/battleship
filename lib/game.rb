require './lib/ship'
require './lib/cell'
require './lib/board'
require './lib/turn'


class Game

  attr_reader :user_board, :comp_board
  #we have instance variables that I'm not sure are in use

  def initialize
    @comp_board = Board.new
    @user_board = Board.new
    @user_previous_shots = []
    @cpu_previous_shots = []

    # require "pry"; binding.pry
  end

  def user_take_turn
    #Error message to check on
    #Choose a coordinate upon which to fire.
#F3
#Please input a valid coordinate.
#G5
#Traceback (most recent call last):
#        2: from battleship_runner.rb:17:in `<main>'
#        1: from /Users/ea/turing/1mod/projects/battleship/lib/game.rb:36:in `user_take_turn'
#/Users/ea/turing/1mod/projects/battleship/lib/turn.rb:12:in `take_shot': undefined method `fire_upon' for nil:NilClass (NoMethodError
#)
    puts "Choose a coordinate upon which to fire."
    pre_fire = gets.chomp
    fire = pre_fire.slice(0,1).capitalize + pre_fire.slice(1..-1)

    unless @comp_board.cells.include?(fire)
      puts "Please input a valid coordinate."
      pre_fire = gets.chomp
      fire = pre_fire.slice(0,1).capitalize + pre_fire.slice(1..-1)
    end

    turn = Turn.new(fire, @comp_board)

    while @user_previous_shots.include?(fire)
      puts "That cell has already been shot. Please choose another."
      pre_fire = gets.chomp
      fire = pre_fire.slice(0,1).capitalize + pre_fire.slice(1..-1)
      turn = Turn.new(fire, @comp_board)
    end
  turn.take_shot
  @user_previous_shots << turn.shot
  end

  def cpu_take_turn
    fire = @user_board.cells.keys.shuffle.first

    unless @user_board.cells.include?(fire)
      puts "Please input a valid coordinate:"
      fire = @user_board.cells.keys.shuffle.first
    end

    turn = Turn.new(fire, @user_board)

    while @cpu_previous_shots.include?(fire)
      fire = @user_board.cells.keys.shuffle.first
      turn = Turn.new(fire, @user_board)
    end
  turn.take_shot
  @cpu_previous_shots << turn.shot
  end

  def start_game

    puts "Welcome to BATTLESHIP"
    puts "Enter p to play. Enter q to quit."
    user_choice = gets.chomp
    if user_choice == "q"
      puts "You chose quit. Have a nice day!"
    elsif user_choice == "p"
      puts "You chose to start. Welcome!"
      puts "-" * 30
    end
    # require "pry"; binding.pry
  end

  def set_comp_board_size
    # require "pry"; binding.pry
    @comp_board.size = @user_board.size

    width_num = (1..@comp_board.size).to_a
    height_num = width_num.map(&:clone)
    width = width_num.map {|num| num.to_s}
    height = height_num.map {|num| (num += 64).chr}

    list = height.map do |letter|
      width.map {|num| [letter, num].join}
    end

    list.flatten.each do |coordinate|
      @comp_board.cells[coordinate] = Cell.new(coordinate)
    end
    # require "pry"; binding.pry

    @user_board.render_first_row("your")
    @user_board.renders
    puts "Please place your ships on the board above:"
  end

  def user_input_first_ship
    #prompt user for ship size and ship name
    puts "How many cells would you like your first ship to be?"
    ship_size = gets.chomp.to_i
    while ship_size < 2
      puts "Ship is too small."
      puts "How many cells would you like your new ship to be? Input at least 2."
      ship_size = gets.chomp.to_i
    end
    while ship_size > @user_board.size
      puts "Ship is too big for the board. Try again."
      ship_size = gets.chomp.to_i
    end
    puts "What name would you like to give to your ship?"
    ship_name = gets.chomp.to_s

    #ship size must be equal or less than board size
    ship1 = Ship.new(ship_name, ship_size)

    user_cruiser_cell_1 = "C5"
    user_cruiser_cell_2 = "E9"
    user_cruiser_cell_3 = "Z3"
    user_cruiser_cells = [user_cruiser_cell_1, user_cruiser_cell_2, user_cruiser_cell_3]
    counter = 1

    while @user_board.valid_placement_consecutive?(ship1, user_cruiser_cells) == false
      user_cruiser_cells = []
      until counter == (ship_size + 1)
        puts "Enter the cells in which you would like to place the #{ship_name} one at a time:"
        puts "Coordinate #{counter}:"
        new_cruiser_cell_1 = gets.chomp
        user_cruiser_cell_1 = new_cruiser_cell_1.slice(0,1).capitalize + new_cruiser_cell_1.slice(1..-1)

        while @user_board.valid_coordinate?(user_cruiser_cell_1) == false
          puts "This is not a valid coordinate for the #{ship_name}. Please input a valid coordinate:"
          new_cruiser_cell_1 = gets.chomp
          user_cruiser_cell_1 = new_cruiser_cell_1.slice(0,1).capitalize + new_cruiser_cell_1.slice(1..-1)
        end
        counter += 1
        user_cruiser_cells << user_cruiser_cell_1
      end
      if @user_board.valid_placement_consecutive?(ship1, user_cruiser_cells) == false
        puts "Your coordinates were not consecutive. Please try again."
      end
    end
    comp_place_coordinates(ship1.length)
    @user_board.place(ship1, user_cruiser_cells)
    @user_board.render_first_row("your")
    @user_board.renders(true)

    # require "pry"; binding.pry
  end

  def user_input_other_ships
    puts "Would you like to add another ship to your board? Y or N?"
    user_input = gets.chomp.to_s.upcase
    while user_input == "Y"
    puts "How many cells would you like your new ship to be? Input at least 2."
    ship_size = gets.chomp.to_i
    while ship_size < 2
      puts "Ship is too small."
      puts "How many cells would you like your new ship to be? Input at least 2."
      ship_size = gets.chomp.to_i
    end
    while ship_size > @user_board.size
      puts "Ship is too big for the board. Try again."
      ship_size = gets.chomp.to_i
    end
    puts "What name would you like to give to your ship?"
    ship_name = gets.chomp.to_s

    ship = Ship.new(ship_name, ship_size)

    user_cruiser_cell_1 = "C5"
    user_cruiser_cell_2 = "E9"
    user_cruiser_cell_3 = "Z3"
    user_cruiser_cells = [user_cruiser_cell_1, user_cruiser_cell_2, user_cruiser_cell_3]
    counter = 1

    while @user_board.valid_placement_consecutive?(ship, user_cruiser_cells) == false
      user_cruiser_cells = []
      until counter == (ship_size + 1)
        puts "Enter the cells in which you would like to place the #{ship_name} one at a time:"
        puts "Coordinate #{counter}:"
        new_cruiser_cell_1 = gets.chomp
        user_cruiser_cell_1 = new_cruiser_cell_1.slice(0,1).capitalize + new_cruiser_cell_1.slice(1..-1)

        while @user_board.valid_coordinate?(user_cruiser_cell_1) == false
          puts "This is not a valid coordinate for your cruiser. Please input a valid coordinate."
          new_cruiser_cell_1 = gets.chomp
          user_cruiser_cell_1 = new_cruiser_cell_1.slice(0,1).capitalize + new_cruiser_cell_1.slice(1..-1)
        end
        counter += 1
        user_cruiser_cells << user_cruiser_cell_1
      end
      if @user_board.valid_placement_consecutive?(ship, user_cruiser_cells) == false
        puts "Your coordinates were not consecutive. Please try again."
      end
    end

    while @user_board.valid_placement_no_overlap?(ship, user_cruiser_cells) == false
      puts "You have overlapping ships. Try again!"

      puts "How many cells would you like your new ship to be? Input at least 2."
      ship_size = gets.chomp.to_i
      while ship_size > @user_board.size
        puts "Ship is too big for the board. Try again."
        ship_size = gets.chomp.to_i
      end
      while ship_size < 2
        puts "Ship is too small."
        puts "How many cells would you like your new ship to be? Input at least 2."
        ship_size = gets.chomp.to_i
      end
      puts "What name would you like to give to your ship?"
      ship_name = gets.chomp.to_s

      ship = Ship.new(ship_name, ship_size)

      user_cruiser_cell_1 = "C5"
      user_cruiser_cell_2 = "E9"
      user_cruiser_cell_3 = "Z3"
      user_cruiser_cells = [user_cruiser_cell_1, user_cruiser_cell_2, user_cruiser_cell_3]
      counter = 1

      while @user_board.valid_placement_consecutive?(ship, user_cruiser_cells) == false
        user_cruiser_cells = []
        until counter == (ship_size + 1)
          puts "Enter the cells in which you would like to place the #{ship_name} one at a time:"
          puts "Coordinate #{counter}:"
          new_cruiser_cell_1 = gets.chomp
          user_cruiser_cell_1 = new_cruiser_cell_1.slice(0,1).capitalize + new_cruiser_cell_1.slice(1..-1)

          while @user_board.valid_coordinate?(user_cruiser_cell_1) == false
            puts "This is not a valid coordinate for the #{ship_name}. Please input a valid coordinate:"
            new_cruiser_cell_1 = gets.chomp
            user_cruiser_cell_1 = new_cruiser_cell_1.slice(0,1).capitalize + new_cruiser_cell_1.slice(1..-1)
          end
          counter += 1
          user_cruiser_cells << user_cruiser_cell_1
        end
        if @user_board.valid_placement_consecutive?(ship, user_cruiser_cells) == false
          puts "Your coordinates were not consecutive. Please try again."
        end
      end
    end
    # while @user_board.valid_placement_consecutive?(submarine, user_submarine_cells) == false
    #   puts "Enter the cells in which you would like to place your sub one at a time:"
    #   puts "First coordinate:"
    #   new_submarine_cell_1 = gets.chomp
    #   user_submarine_cell_1 = new_submarine_cell_1.slice(0,1).capitalize + new_submarine_cell_1.slice(1..-1)
    #
    #   while @user_board.valid_coordinate?(user_submarine_cell_1) == false
    #     puts "This is not a valid coordinate for your submarine. Please input your first coordinate with a row letter between A and D and a column number between 1 and 4:"
    #     new_submarine_cell_1 = gets.chomp
    #     user_submarine_cell_1 = new_submarine_cell_1.slice(0,1).capitalize + new_submarine_cell_1.slice(1..-1)
    #   end
    #
    #   puts "Second coordinate:"
    #   new_submarine_cell_2 = gets.chomp
    #   user_submarine_cell_2 = new_submarine_cell_2.slice(0,1).capitalize + new_submarine_cell_2.slice(1..-1)
    #   while @user_board.valid_coordinate?(user_submarine_cell_2) == false
    #     puts "This is not a valid coordinate for your submarine. Please input your second coordinate with a row letter between A and D and a column number between 1 and 4:"
    #     new_submarine_cell_2 = gets.chomp
    #     user_submarine_cell_2 = new_submarine_cell_2.slice(0,1).capitalize + new_submarine_cell_2.slice(1..-1)
    #   end
    #
    #   user_submarine_cells = [user_submarine_cell_1, user_submarine_cell_2]
    #
    #   if @user_board.valid_placement_consecutive?(submarine, user_submarine_cells) == false
    #     puts "Your coordinates were not consecutive. Please try again."
    #   end
    # end

    # while @user_board.valid_placement_no_overlap?(submarine, user_submarine_cells) == false
    #   submarine = Ship.new("Submarine", 2)
    #   user_submarine_cell_1 = "C5"
    #   user_submarine_cell_2 = "E9"
    #   user_submarine_cells = [user_submarine_cell_1, user_submarine_cell_2]
    #   puts "You have overlapping ships. Try again!"
    #   while @user_board.valid_placement_consecutive?(submarine, user_submarine_cells) == false
    #     puts "Enter the cells in which you would like to place your sub one at a time:"
    #     puts "First coordinate:"
    #     new_submarine_cell_1 = gets.chomp
    #     user_submarine_cell_1 = new_submarine_cell_1.slice(0,1).capitalize + new_submarine_cell_1.slice(1..-1)
    #
    #     while @user_board.valid_coordinate?(user_submarine_cell_1) == false
    #       puts "This is not a valid coordinate for your submarine. Please input your first coordinate with a row letter between A and D and a column number between 1 and 4:"
    #       new_submarine_cell_1 = gets.chomp
    #       user_submarine_cell_1 = new_submarine_cell_1.slice(0,1).capitalize + new_submarine_cell_1.slice(1..-1)
    #     end
    #
    #     puts "Second coordinate:"
    #     new_submarine_cell_2 = gets.chomp
    #     user_submarine_cell_2 = new_submarine_cell_2.slice(0,1).capitalize + new_submarine_cell_2.slice(1..-1)
    #     while @user_board.valid_coordinate?(user_submarine_cell_2) == false
    #       puts "This is not a valid coordinate for your submarine. Please input your second coordinate with a row letter between A and D and a column number between 1 and 4:"
    #       new_submarine_cell_2 = gets.chomp
    #       user_submarine_cell_2 = new_submarine_cell_2.slice(0,1).capitalize + new_submarine_cell_2.slice(1..-1)
    #     end
    #
    #     user_submarine_cells = [user_submarine_cell_1, user_submarine_cell_2]
    #
    #     if @user_board.valid_placement_consecutive?(submarine, user_submarine_cells) == false
    #       puts "Your coordinates were not consecutive. Please try again."
    #     end
    #   end
    # end
    comp_place_coordinates(ship.length)
    @user_board.place(ship, user_cruiser_cells)
    @user_board.render_first_row("your")
    @user_board.renders(true)
    puts "Would you like to place another ship? Y or N?"
    user_input = gets.chomp.to_s.upcase
  end
  end

  def comp_place_coordinates(length)
    ship = Ship.new("Ship", length)

    comp_ship_placement = comp_random_coordinates(length)

    while @comp_board.valid_placement_no_overlap?(ship, comp_random_coordinates(length)) == false
      comp_ship_placement = comp_random_coordinates(length)
    end
    @comp_board.place(ship, comp_random_coordinates(length))
  end

  def comp_random_coordinates(length)
    comp_coordinates = nil

    width_num = (1..@comp_board.size).to_a
    height_num = width_num.map(&:clone)
    width = width_num.map {|num| num.to_s}
    height = height_num.map {|num| (num += 64).chr}

    comp_coordinates_width_array = []
    comp_coordinates_height_array = []
    width_num.each_cons(length) {|arr| comp_coordinates_width_array << arr}
    height_num.each_cons(length) {|arr| comp_coordinates_height_array << arr}

    comp_coordinates_width = comp_coordinates_width_array.sample
    #random array of horizontal coordinates
    comp_coordinates_height = comp_coordinates_height_array.sample
    #random array of vertical coordinates

    comp_coordinate_horiz = width.sample
    #one element of number strings array
    comp_coordinate_vert = height.sample
    #one element of letter strings array

    comp_coordinates_horiz_choice = comp_coordinates_width.map do |num|
      comp_coordinate_vert + num.to_s
    end

    comp_coordinates_vert_choice = comp_coordinates_height.map do |letter|
      (letter += 64).chr + comp_coordinate_horiz
    end

    comp_coordinates = [comp_coordinates_vert_choice, comp_coordinates_horiz_choice].sample

    comp_coordinates
  end

end
