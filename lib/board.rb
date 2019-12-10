require "./lib/cell"
require "./lib/game"
class Board

  attr_reader :cells
  attr_accessor :size
  def initialize
    @cells = {}
    @size = nil
     # require "pry"; binding.pry
  end

  def set_board_size
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
    # require "pry"; binding.pry
  end

  def valid_placement_consecutive?(ship, array)
    split_coordinate = array.map do |coordinate|
      coordinate.split""
    end

    coord_numbers = split_coordinate.map {|array| array[1].to_i}
    num_check_consecutive = coord_numbers == (coord_numbers.min..coord_numbers.max).to_a && coord_numbers.length == array.length
    num_check_equal = nil == coord_numbers.find {|number| coord_numbers[0] != number}

    coord_letters = split_coordinate.map {|array| array[0].ord}
    letter_check_consecutive = coord_letters == (coord_letters.min..coord_letters.max).to_a && coord_letters.length == array.length
    letter_check_equal = nil == coord_letters.find {|letter| coord_letters[0] != letter}

    (num_check_consecutive == true && letter_check_equal == true) || (num_check_equal == true && letter_check_consecutive == true)
    # require "pry"; binding.pry
  end

  def renders(player, arg = false)
    puts "This is #{player} board."
    "  1 2 3 4 \n" +
"A #{@cells["A1"].render(arg)} #{@cells["A2"].render(arg)} #{@cells["A3"].render(arg)} #{@cells["A4"].render(arg)} \n" +
"B #{@cells["B1"].render(arg)} #{@cells["B2"].render(arg)} #{@cells["B3"].render(arg)} #{@cells["B4"].render(arg)} \n" +
"C #{@cells["C1"].render(arg)} #{@cells["C2"].render(arg)} #{@cells["C3"].render(arg)} #{@cells["C4"].render(arg)} \n" +
"D #{@cells["D1"].render(arg)} #{@cells["D2"].render(arg)} #{@cells["D3"].render(arg)} #{@cells["D4"].render(arg)} \n"


    # width_num = (1..@size).to_a
    # height_num = width_num.map(&:clone)
    # width = width_num.map {|num| num.to_s}
    # height = height_num.map {|num| (num += 64).chr}
    #
    # print "  "
    # width.each do |num|
    #   print "#{num} "
    # end
    # print "\n"
    #
    # split_coordinate = @cells.keys.map {|coordinate| coordinate.split''}
    #
    #
    # height.each do |letter|
    #   print letter
    #   while letter ==

  end

end
