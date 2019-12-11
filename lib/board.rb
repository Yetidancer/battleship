require "./lib/cell"
require "./lib/game"
class Board

  attr_reader :cells
  attr_accessor :size
  def initialize
    @cells = {
      "A1" => cell_1 
    }
    @size = 4
  end

  def set_board_size
    @cells = {}

    puts "What size would you like the board to be? Enter an integer between 4 and 26:"

    @size = gets.chomp.to_i

    until @size < 27 && @size > 3 && @size.is_a?(Integer)
      puts "That is not a valid size, please enter an integer between 4 and 26:"
      @size = gets.chomp.to_i
    end

    width_num = (1..@size).to_a
    height_num = width_num.map(&:clone)
    width = width_num.map {|num| num.to_s}
    height = height_num.map {|num| (num += 64).chr}

    list = height.map do |letter|
      width.map {|num| [letter, num].join}
    end

    list.flatten.each do |coordinate|
      @cells[coordinate] = Cell.new(coordinate)
    end

  end

  def place(ship, coordinates)
    coordinates.each do |coordinate|
      @cells[coordinate].place_ship(ship)
    end
  end

  def valid_coordinate?(coordinate)
    return true if @cells[coordinate]
    false
  end

  def valid_placement_no_overlap?(ship, coordinates)
    return false if coordinates.find do |coordinate|
      @cells[coordinate].ship != nil
    end
    true
  end

  def valid_placement_length?(ship, array)
    return true if ship.length == array.length
  end

  def valid_placement_consecutive?(ship, array)
    return false if array.length == 1
    split_coordinate = array.map do |coordinate|
      coordinate.split("",2)
    end

    coord_numbers = split_coordinate.map {|array| array[1].to_i}
    num_check_consecutive = coord_numbers == (coord_numbers.min..coord_numbers.max).to_a && coord_numbers.length == array.length
    num_check_equal = nil == coord_numbers.find {|number| coord_numbers[0] != number}

    coord_letters = split_coordinate.map {|array| array[0].ord}
    letter_check_consecutive = coord_letters == (coord_letters.min..coord_letters.max).to_a && coord_letters.length == array.length
    letter_check_equal = nil == coord_letters.find {|letter| coord_letters[0] != letter}

    (num_check_consecutive == true && letter_check_equal == true) || (num_check_equal == true && letter_check_consecutive == true)
  end

  def render_first_row(player)
    width_num = (1..@size).to_a
    height_num = width_num.map(&:clone)
    width = width_num.map {|num| num.to_s}
    height = height_num.map {|num| (num += 64).chr}

    rendering_string << "This is #{player} board."
    rendering_string << "-" * (@size * 3) + "-"
    rendering_string << "   "
    width.each do |num|
      if num.to_i > 8
        rendering_string << "#{num} "
      else
        rendering_string << "#{num}  "
      end
    end
    rendering_string << "\n"
    rendering_string
  end

  def renders(arg = false)
    width_num = (1..@size).to_a
    height_num = width_num.map(&:clone)
    width = width_num.map {|num| num.to_s}
    height = height_num.map {|num| (num += 64).chr}

    split_coordinate = @cells.keys.map {|coordinate| coordinate.split('',2)}


    rendering_string = ""

    height.each do |letter|
      rendering_string << letter + "  "
      split_coordinate.each do |array|
        if letter == array[0]
          rendering_string << (@cells[array[0] + array[1]].render(arg) + "  ")
        end
      end
      rendering_string << "\n"
    end
    rendering_string << "-" * (@size * 3) + "-"
    rendering_string
  end

end
