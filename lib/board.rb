require "./lib/cell"
class Board

  attr_reader :cells
  def initialize
    @cells = {
      "A1" => (cell = Cell.new("A1")),
      "A2" => (cell = Cell.new("A2")),
      "A3" => (cell = Cell.new("A3")),
      "A4" => (cell = Cell.new("A4")),
      "B1" => (cell = Cell.new("B1")),
      "B2" => (cell = Cell.new("B2")),
      "B3" => (cell = Cell.new("B3")),
      "B4" => (cell = Cell.new("B4")),
      "C1" => (cell = Cell.new("C1")),
      "C2" => (cell = Cell.new("C2")),
      "C3" => (cell = Cell.new("C3")),
      "C4" => (cell = Cell.new("C4")),
      "D1" => (cell = Cell.new("D1")),
      "D2" => (cell = Cell.new("D2")),
      "D3" => (cell = Cell.new("D3")),
      "D4" => (cell = Cell.new("D4"))
    }
     #require "pry"; binding.pry
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
    # cell_1 = array[0].split''
    # cell_2 = array[1].split''
    # number_1 = cell_1[1].to_i
    # number_2 = cell_2[1].to_i
    # letter_1 = cell_1[0].ord
    # letter_2 = cell_2[0].ord
    # require "pry"; binding.pry
    # if (number_2 - number_1 == 1 && letter_1 == letter_2) ||
    #   (letter_2 - letter_1 == 1 && number_1 == number_2)
    #   true
    if array.length == 2
      cell_1 = array[0].split''
      cell_2 = array[1].split''
      number_1 = cell_1[1].to_i
      number_2 = cell_2[1].to_i
      letter_1 = cell_1[0].ord
      letter_2 = cell_2[0].ord
      # require "pry"; binding.pry
      if (number_2 - number_1 == 1 && letter_1 == letter_2) || (letter_2 - letter_1 == 1 && number_1 == number_2)
        true
      else
        false
      end
    elsif array.length == 3
      cell_1 = array[0].split''
      cell_2 = array[1].split''
      cell_3 = array[2].split''
      number_1 = cell_1[1].to_i
      number_2 = cell_2[1].to_i
      number_3 = cell_3[1].to_i
      letter_1 = cell_1[0].ord
      letter_2 = cell_2[0].ord
      letter_3 = cell_3[0].ord
# require "pry"; binding.pry
      if (number_2 - number_1 == 1 && letter_1 == letter_2) && (number_3 - number_2 == 1 && letter_2 == letter_3) || ((letter_2 - letter_1 == 1 && number_1 == number_2) && (letter_3 - letter_2 == 1 && number_2 == number_3))
        true
      else
        false
      end
    elsif array.length == 4
      cell_1 = array[0].split''
      cell_2 = array[1].split''
      cell_3 = array[2].split''
      cell_4 = array[3].split''
      number_1 = cell_1[1].to_i
      number_2 = cell_2[1].to_i
      number_3 = cell_3[1].to_i
      number_4 = cell_4[1].to_i
      letter_1 = cell_1[0].ord
      letter_2 = cell_2[0].ord
      letter_3 = cell_3[0].ord
      letter_4 = cell_4[0].ord

      # require "pry"; binding.pry
      if ((number_2 - number_1 == 1 && letter_1 == letter_2) && (number_3 - number_2 == 1 && letter_2 == letter_3) && (number_4 - number_3 == 1 && letter_3 == letter_4)) || ((letter_2 - letter_1 == 1 && number_1 == number_2) && (letter_3 - letter_2 == 1 && number_2 == number_3) && (letter_4 - letter_3 == 1 && number_3 == number_4))
        true
      else
        false
      end
    else
      false
    end
  end

  def renders(player, arg = false)
    puts "This is #{player} board."
    "  1 2 3 4 \n" +
"A #{@cells["A1"].render(arg)} #{@cells["A2"].render(arg)} #{@cells["A3"].render(arg)} #{@cells["A4"].render(arg)} \n" +
"B #{@cells["B1"].render(arg)} #{@cells["B2"].render(arg)} #{@cells["B3"].render(arg)} #{@cells["B4"].render(arg)} \n" +
"C #{@cells["C1"].render(arg)} #{@cells["C2"].render(arg)} #{@cells["C3"].render(arg)} #{@cells["C4"].render(arg)} \n" +
"D #{@cells["D1"].render(arg)} #{@cells["D2"].render(arg)} #{@cells["D3"].render(arg)} #{@cells["D4"].render(arg)} \n"
  end

end
