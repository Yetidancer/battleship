require './lib/ship'

class Cell

  attr_reader :coordinate, :ship, :fired_on

  def initialize(coordinate)
    @coordinate = coordinate
    @ship = nil
    @fired_on = false
  end

  def empty?
    return true if @ship == nil
    false
  end

  def place_ship(ship)
    @ship = ship 
  end

  def fired_upon?
    @fired_on
  end

  def fire_upon
    if @ship == nil
      @fired_on = true
    else
    @ship.hit
    @fired_on = true
    end
  end

  def sunk_ship?
    return true if @ship.sunk? == true
    false
  end

  def render(arg = false)
    return "S" if arg == true && ship != nil && fired_upon? == false
    return "." if fired_upon? == false
    return "M" if fired_upon? == true && empty? == true
    return "H" if fired_upon? == true && sunk_ship? == false
    return "X" if fired_upon? == true && sunk_ship? == true
  end
end
