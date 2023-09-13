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

  def scale(scalar)
    Vector.new(@x * scalar, @y * scalar)
  end

  def to_s
    "x: #{@x}, y: #{@y}"
  end
end

class Astronaut
  attr_reader :position

  def initialize
    @image = Gosu::Image.new("assets/rocket-ship-png-30457.png")
    @motionMPS = Vector.new(100, 0)
    @position = Vector.new(25, 25)
    @orientation = 0
  end

  def tick(secondsElapsed)
    @position = @position + @motionMPS.scale(secondsElapsed)
  end

  def draw
    puts "time: #{Time.now} pos #{@position}"
    @image.draw_rot(@position.x, @position.y, 0, @orientation, 0.5, 0.5)
  end
end

class AstronautSimulation < Gosu::Window
  def initialize
    super 1280, 720
    self.caption = "Astronaut simulation"
    @astronaut = Astronaut.new
    @lastTime = Time.now
    @log = File.open("event.log", "w")
    @event_buffer = []
  end

  def update
    now = Time.now
    secondsElapsed = now - @lastTime
    @astronaut.tick(secondsElapsed)
    @lastTime = now
  end

  def button_down(id)
    event = ButtonDownEvent.new(id)
    @event_buffer << event
    dump_event(event)
  end

  def draw
    c = Gosu::Color::AQUA
    draw_quad(0, 0, c, width, 0, c, width, height, c, 0, height, c)
    @astronaut.draw
  end
end

AstronautSimulation.new.show
