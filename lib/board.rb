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
    # require "pry"; binding.pry
  end

  def valid_coordinate?(coordinate)
    return true if @cells[coordinate]
    false
  end

  def valid_placement_length?(ship, array)
    return true if ship.length == array.length
    # require "pry"; binding.pry
  end

  def valid_placement_consecutive?(ship, array)
    cell_1 = array[0].split''
    cell_2 = array[1].split''
    number_1 = cell_1[1].to_i
    number_2 = cell_2[1].to_i
    letter_1 = cell_1[0].ord
    letter_2 = cell_2[0].ord
    # require "pry"; binding.pry
    if (number_2 - number_1 == 1 && letter_1 == letter_2) ||
      (letter_2 - letter_1 == 1 && number_1 == number_2)
      true
    else
      false
    end
    # require "pry"; binding.pry
  end

  

end
