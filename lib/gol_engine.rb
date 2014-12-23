require 'world'
require 'cell'

class GolEngine
  def initialize(width, height)
    @width  = width
    @height = height
    @world  = World.new(width, height)
    @world.populate Cell
  end

  def initial_pattern(*coordinates)
    coordinates.each do |x, y|
      @world.set(x, y, Cell.new(:alive))
    end
  end

  def run(rounds)
    render
    rounds.times do
      calculate_cycle
      apply
      render
    end
  end

  def calculate_cycle
    @world.each do |x, y, cell|
      neighbours = @world.find_neighbours(x, y)
      alive_count = neighbours.reduce(0) { |count, neighbour| count += 1 if neighbour.is_alive?; count }
      if cell.is_dead? && alive_count == 3
        cell.live!
      end
      if cell.is_alive? && (alive_count < 2 || alive_count > 3)
        cell.die!
      end
    end
  end

  def apply
    @world.each do |x, y, cell|
      cell.apply
    end
  end

  def render
    # sleep(0.0)
    system 'clear'
    @world.each_row do |row|
      row.each do |cell|
        if cell.is_alive?
          print "\u273A".encode('utf-8')
        else
          print ' '
        end
      end
      print "|\n"
    end
    print "–" * @width
  end
end