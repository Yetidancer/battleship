require './lib/ship'
require './lib/cell'
require './lib/board'
require './lib/turn'


class Game

  attr_reader :user_board, :comp_board, :previous_shots, :user_cruiser, :user_sub #we have instance variables that I'm not sure are in use

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
    fire = gets.chomp

    unless @comp_board.cells.include?(fire)
      puts "Please input a valid coordinate."
      fire = gets.chomp
    end

    turn = Turn.new(fire, @comp_board)

    while @user_previous_shots.include?(fire)
      puts "That cell has already been shot. Please choose another."
      fire = gets.chomp
      turn = Turn.new(fire, @comp_board)
    end
  turn.take_shot
  @user_previous_shots << turn.shot
  end

  def cpu_take_turn
    fire = @user_board.cells.keys.shuffle.first

    unless @user_board.cells.include?(fire)
      puts "Please input a valid coordinate."
      fire = @user_board.cells.keys.shuffle.first
    end

    turn = Turn.new(fire, @user_board)

    while @cpu_previous_shots.include?(fire)
      fire = @comp_board.cells.keys.shuffle.first
      turn = Turn.new(fire, @comp_board)
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
    #computer generate random ship coordinates and assign them to cells
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
  end

  def user_input_cruiser_cells
    # comp_place_coordinates

    cruiser = Ship.new("Cruiser", 3)
    user_cruiser_cell_1 = "C5"
    user_cruiser_cell_2 = "E9"
    user_cruiser_cell_3 = "Z3"
    user_cruiser_cells = [user_cruiser_cell_1, user_cruiser_cell_2, user_cruiser_cell_3]
# require "pry"; binding.pry
    while @user_board.valid_placement_consecutive?(cruiser, user_cruiser_cells) == false
      puts "Enter the cells in which you would like to place your cruiser one at a time:"
      puts "First coordinate:"
    user_cruiser_cell_1 = gets.chomp
# require "pry"; binding.pry
      while @user_board.valid_coordinate?(user_cruiser_cell_1) == false
        puts "This is not a valid coordinate for your cruiser. Please input your first coordinate with a row letter between A and D and a column number between 1 and 4:"
        user_cruiser_cell_1 = gets.chomp
      end
      # require "pry"; binding.pry
      puts "Second coordinate:"
      user_cruiser_cell_2 = gets.chomp
      while @user_board.valid_coordinate?(user_cruiser_cell_2) == false
        puts "This is not a valid coordinate for your cruiser. Please input your second coordinate with a row letter between A and D and a column number between 1 and 4:"
        user_cruiser_cell_2 = gets.chomp
      end

      puts "Third coordinate:"
      user_cruiser_cell_3 = gets.chomp
      while @user_board.valid_coordinate?(user_cruiser_cell_3) == false
        puts "This is not a valid coordinate for your cruiser. Please input your third coordinate with a row letter between A and D and a column number between 1 and 4:"
        user_cruiser_cell_3 = gets.chomp
      end

        user_cruiser_cells = [user_cruiser_cell_1, user_cruiser_cell_2, user_cruiser_cell_3]

      if @user_board.valid_placement_consecutive?(cruiser, user_cruiser_cells) == false
        puts "Your coordinates were not consecutive. Please try again."
      end

    #require "pry"; binding.pry
    end
    @user_board.place(cruiser, user_cruiser_cells)
    # require "pry"; binding.pry
  end

  def user_input_submarine_cells
    submarine = Ship.new("Submarine", 2)
    user_submarine_cell_1 = "C5"
    user_submarine_cell_2 = "E9"
    user_submarine_cells = [user_submarine_cell_1, user_submarine_cell_2]
# require "pry"; binding.pry
    while @user_board.valid_placement_consecutive?(submarine, user_submarine_cells) == false
      puts "Enter the cells in which you would like to place your sub one at a time:"
      puts "First coordinate:"
    user_submarine_cell_1 = gets.chomp
# require "pry"; binding.pry
      while @user_board.valid_coordinate?(user_submarine_cell_1) == false
        puts "This is not a valid coordinate for your submarine. Please input your first coordinate with a row letter between A and D and a column number between 1 and 4:"
        user_submarine_cell_1 = gets.chomp
      end
      # require "pry"; binding.pry
      puts "Second coordinate:"
      user_submarine_cell_2 = gets.chomp
      while @user_board.valid_coordinate?(user_submarine_cell_2) == false
        puts "This is not a valid coordinate for your submarine. Please input your second coordinate with a row letter between A and D and a column number between 1 and 4:"
        user_submarine_cell_2 = gets.chomp
      end
      # require "pry"; binding.pry
      user_submarine_cells = [user_submarine_cell_1, user_submarine_cell_2]
      # require "pry"; binding.pry
      if @user_board.valid_placement_consecutive?(submarine, user_submarine_cells) == false
        puts "Your coordinates were not consecutive. Please try again."
      end

    #require "pry"; binding.pry
    end

    while @user_board.valid_placement_no_overlap?(submarine, user_submarine_cells) == false
      submarine = Ship.new("Submarine", 2)
      user_submarine_cell_1 = "C5"
      user_submarine_cell_2 = "E9"
      user_submarine_cells = [user_submarine_cell_1, user_submarine_cell_2]
      puts "You have overlapping ships. Try again!"
      while @user_board.valid_placement_consecutive?(submarine, user_submarine_cells) == false
        puts "Enter the cells in which you would like to place your sub one at a time:"
        puts "First coordinate:"
      user_submarine_cell_1 = gets.chomp
  # require "pry"; binding.pry
        while @user_board.valid_coordinate?(user_submarine_cell_1) == false
          puts "This is not a valid coordinate for your submarine. Please input your first coordinate with a row letter between A and D and a column number between 1 and 4:"
          user_submarine_cell_1 = gets.chomp
        end
        # require "pry"; binding.pry
        puts "Second coordinate:"
        user_submarine_cell_2 = gets.chomp
        while @user_board.valid_coordinate?(user_submarine_cell_2) == false
          puts "This is not a valid coordinate for your submarine. Please input your second coordinate with a row letter between A and D and a column number between 1 and 4:"
          user_submarine_cell_2 = gets.chomp
        end

        user_submarine_cells = [user_submarine_cell_1, user_submarine_cell_2]
      #require "pry"; binding.pry
        if @user_board.valid_placement_consecutive?(submarine, user_submarine_cells) == false
          puts "Your coordinates were not consecutive. Please try again."
        end
      end
    end
    @user_board.place(submarine, user_submarine_cells)
    # require "pry"; binding.pry
  end

  def comp_place_coordinates
    require "pry"; binding.pry
    cruiser_placement = comp_coordinates_cruiser
    cruiser = Ship.new("Cruiser", 3)
    @comp_board.place(cruiser, cruiser_placement)
    submarine_placement = comp_coordinates_submarine
    submarine = Ship.new("Submarine", 2)
    require "pry"; binding.pry

    while @comp_board.valid_placement_no_overlap?(submarine, submarine_placement) == false
      # require "pry"; binding.pry
      submarine_placement = comp_coordinates_submarine
    end
    @comp_board.place(submarine, submarine_placement)
    # require "pry"; binding.pry
  end

  def comp_coordinates_cruiser
    comp_coordinates_cruiser = []
    comp_coordinates_cruiser << hor_random_3
    comp_coordinates_cruiser << vert_random_3
    comp_coordinates_cruiser.shuffle.first
    # require "pry"; binding.pry
  end

  def comp_coordinates_submarine
    comp_coordinates_submarine = []
    comp_coordinates_submarine << vert_random_2
    comp_coordinates_submarine << hor_random_2
    comp_coordinates_submarine.shuffle.first
  end

  def vert_random_3
    coordinates = []
    board_co = ["A1", "A2", "A3", "A4", "B1", "B2", "B3", "B4"]
    coord = board_co.shuffle.first
    rando = [coord]
    coordinates << coord

    cell_1 = rando[0].split''
    letter_1 = cell_1[0].ord
    number_1 = cell_1[1].to_i
    letter_2 = letter_1 + 1
    number_2 = number_1
    coord_1 = letter_2.chr + number_2.to_s
    coordinates << coord_1

    letter_3 = letter_2 + 1
    number_3 = number_2
    coord_2 = letter_3.chr + number_3.to_s
    coordinates << coord_2

    return coordinates
  end

  def hor_random_3
    coordinates = []
    board_co = ["A1", "A2", "B1", "B2", "C1", "C2", "D1", "D2"]
    coord = board_co.shuffle.first
    rando = [coord]
    coordinates << coord

    cell_1 = rando[0].split''
    letter_1 = cell_1[0].ord
    number_1 = cell_1[1].to_i
    letter_2 = letter_1
    number_2 = number_1 + 1
    coord_1 = letter_2.chr + number_2.to_s
    coordinates << coord_1

    letter_3 = letter_2
    number_3 = number_2 + 1
    coord_2 = letter_3.chr + number_3.to_s
    coordinates << coord_2

    return coordinates
  end

  def vert_random_2
    coordinates = []
    board_co = ["A1", "A2", "A3", "A4", "B1", "B2", "B3", "B4", "C1", "C2", "C3", "C4"]
    coord = board_co.shuffle.first
    rando = [coord]
    coordinates << coord

    cell_1 = rando[0].split''
    letter_1 = cell_1[0].ord
    number_1 = cell_1[1].to_i
    letter_2 = letter_1 + 1
    number_2 = number_1
    coord_1 = letter_2.chr + number_2.to_s
    coordinates << coord_1

    return coordinates
  end

  def hor_random_2
    coordinates = []
    board_co = ["A1", "A2", "A3", "B1", "B2", "B3", "C1", "C2", "C3", "D1", "D2", "D3"]
    coord = board_co.shuffle.first
    rando = [coord]
    coordinates << coord

    cell_1 = rando[0].split''
    letter_1 = cell_1[0].ord
    number_1 = cell_1[1].to_i
    letter_2 = letter_1
    number_2 = number_1 + 1
    coord_1 = letter_2.chr + number_2.to_s
    coordinates << coord_1

    return coordinates
  end


end
