require './lib/ship'
require './lib/cell'
require './lib/board'
require './lib/turn'


class Game

  attr_reader :user_board, :comp_board, :previous_shots, :user_cruiser, :user_sub

  def initialize
    @comp_board = Board.new
    @user_board = Board.new
    @previous_shots = []
    @user_cruiser = ''
    @user_sub = ''
    # require "pry"; binding.pry
  end

  def already_shot?(coordinate)
    return true if @previous_shots.include?(coordinate)
  end

  def take_turn
    puts "Choose a coordinate upon which to fire."
    fire = gets.chomp

    turn = Turn.new(fire, @comp_board)

    while @previous_shots.include?(fire)
      puts "That cell has already been shot. Please choose another."
      fire = gets.chomp
      turn = Turn.new(fire, @comp_board)
    end
  turn.take_shot
  @previous_shots << turn.shot
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
    comp_place_coordinates
    #computer generate random ship coordinates and assign them to cells
    # require "pry"; binding.pry
    puts "CPU:
  I have laid out my ships on the grid.
  You now need to lay out your two ships.
  The Cruiser is three units long and the Submarine is two units long.

    1 2 3 4
  A . . . .
  B . . . .
  C . . . .
  D . . . ."


  end

  def user_input_cruiser_cells
    @user_cruiser = Ship.new("Cruiser", 3)
    user_cruiser_cell_1 = "C5"
    user_cruiser_cell_2 = "E9"
    user_cruiser_cell_3 = "Z3"
    user_cruiser_cells = [user_cruiser_cell_1, user_cruiser_cell_2, user_cruiser_cell_3]
# require "pry"; binding.pry
    while @user_board.valid_placement_consecutive?(@user_cruiser, user_cruiser_cells) == false
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

      if @user_board.valid_placement_consecutive?(@user_cruiser, user_cruiser_cells) == false
        puts "Your coordinates were not consecutive. Please try again."
      end

    #require "pry"; binding.pry
    end
    @user_board.place(@user_cruiser, user_cruiser_cells)
    # require "pry"; binding.pry
  end

  def user_input_submarine_cells
    @user_sub = Ship.new("Submarine", 2)
    user_submarine_cell_1 = "C5"
    user_submarine_cell_2 = "E9"
    user_submarine_cells = [user_submarine_cell_1, user_submarine_cell_2]
# require "pry"; binding.pry
    while @user_board.valid_placement_consecutive?(@user_sub, user_submarine_cells) == false
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
      if @user_board.valid_placement_consecutive?(@user_sub, user_submarine_cells) == false
        puts "Your coordinates were not consecutive. Please try again."
      end

    #require "pry"; binding.pry
    end

    while @user_board.valid_placement_no_overlap?(@user_sub, user_submarine_cells) == false
      @user_sub = Ship.new("Submarine", 2)
      user_submarine_cell_1 = "C5"
      user_submarine_cell_2 = "E9"
      user_submarine_cells = [user_submarine_cell_1, user_submarine_cell_2]
      puts "You have overlapping ships. Try again!"
      while @user_board.valid_placement_consecutive?(@user_sub, user_submarine_cells) == false
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
        if @user_board.valid_placement_consecutive?(@user_sub, user_submarine_cells) == false
          puts "Your coordinates were not consecutive. Please try again."
        end
      end
    end
    @user_board.place(@user_sub, user_submarine_cells)
    # require "pry"; binding.pry
  end

  def comp_place_coordinates
    cruiser_placement = comp_coordinates_cruiser
    cruiser = Ship.new("Cruiser", 3)
    @comp_board.place(cruiser, cruiser_placement)
    submarine_placement = comp_coordinates_submarine
    submarine = Ship.new("Submarine", 2)
    # require "pry"; binding.pry

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
