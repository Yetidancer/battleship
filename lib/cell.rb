require './lib/ship'

class Cell

  attr_reader :coordinate, :ship

  def initialize(coordinate)
    @coordinate = coordinate
    @ship = nil #could also use [].first
    @got_fired = false
  end

  def empty?
    return true if @ship == nil
    false
  end

  def place_ship(ship)
    @ship = ship #with [].first for ship, this would be @ship << ship
  end

  def fired_upon?
    @got_fired
  end

  def fire_upon
    if @ship == nil
      @got_fired = true
    else
    @ship.hit
    @got_fired = true
    end
  end

  def render(arg = false)
    return "S" if arg == true
    return "." if fired_upon? == false && @ship == nil
    return "M" if fired_upon? == true && @ship == nil
    return "H" if fired_upon? == true && @ship == true
    return "X" if fired_upon? == true && @ship.sunk? == true

    
  end
end
