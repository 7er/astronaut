require 'gosu'

class Vector
  attr_reader :x, :y
  def initialize(x, y)
    @x = x
    @y = y
  end

  def +(otherVector)
    Vector.new(@x + otherVector.x, @y + otherVector.y)
  end

  def to_s
    "x: #{@x}, y: #{@y}"
  end
end

class Astronaut
  def initialize
    @motion_vector = Vector.new(100, 0)
  end
  def tick
    return @motion_vector
  end
end

class AstronautSimulation < Gosu::Window
  def initialize
    super 800, 600
    self.caption = "Astronaut simulation"
    @position = Vector.new(25,25)
    @astronaut = Astronaut.new
  end

  def update
    motion_vector = @astronaut.tick
    @position = @position + motion_vector
  end

  def draw
    puts "pos #{@position}"
  end
end

AstronautSimulation.new.show
