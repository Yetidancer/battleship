require './lib/ship'
require './lib/cell'
require './lib/board'

class Game

  def initialize
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

    #computer generate random ship coordinates and assign them to cells

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
    board = Board.new
    puts "Enter the cells in which you would like to place your cruiser one at a time:"
    cruiser = Ship.new("Cruiser", 3)
    user_cruiser_cell_1 = "C5"
    user_cruiser_cell_2 = "E9"
    user_cruiser_cell_3 = "Z3"
    user_cruiser_cells = [user_cruiser_cell_1, user_cruiser_cell_2, user_cruiser_cell_3]

    while board.valid_placement_consecutive?(cruiser, user_cruiser_cells) == false

    user_cruiser_cell_1 = gets.chomp
# require "pry"; binding.pry
    while board.valid_coordinate?(user_cruiser_cell_1) == false
      puts "This is not a valid coordinate. Please input a coordinate with a row letter between A and B and a column number between 1 and 4:"
      user_cruiser_cell_1 = gets.chomp
    end
    # require "pry"; binding.pry
    user_cruiser_cell_2 = gets.chomp
    while board.valid_coordinate?(user_cruiser_cell_2) == false
      puts "This is not a valid coordinate. Please input a coordinate with a row letter between A and B and a column number between 1 and 4:"
      user_cruiser_cell_2 = gets.chomp
    end

    user_cruiser_cell_3 = gets.chomp
    while board.valid_coordinate?(user_cruiser_cell_3) == false
      puts "This is not a valid coordinate. Please input a coordinate with a row letter between A and B and a column number between 1 and 4:"
      user_cruiser_cell_3 = gets.chomp
    end
    user_cruiser_cells << user_cruiser_cell_1
    user_cruiser_cells << user_cruiser_cell_2
    user_cruiser_cells << user_cruiser_cell_3
    board.valid_placement_length?(cruiser, user_cruiser_cells)
    board.valid_placement_consecutive?(cruiser, user_cruiser_cells)
    end
    require "pry"; binding.pry
  end

  def comp_coordinates
    require "pry"; binding.pry

    place_1 = comp_ship_type
    needed = 0
    if place_1 == "Cruiser"
      needed += 3
    elsif place_1 == "Submarine"
      needed += 2
    end
    require "pry"; binding.pry

    if needed == 3
      return [hor_random_3, vert_random_3].shuffle.first
    elsif needed == 2
      return [vert_random_2, hor_random_2].shuffle.first
    end
    require "pry"; binding.pry
  end

  def comp_ship_type
    ship_types = ["Cruiser", "Submarine"]
    ship_types.sample
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
