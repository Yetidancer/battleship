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
    @ship.hit
    @got_fired = true
  end
end
