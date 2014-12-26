require 'world'
require 'cell'
require 'renderer/console'

class GolEngine
  def initialize(renderer_type = :console, width = nil, height = nil)
    @renderer = initialize_renderer(renderer_type)
    @world  = World.new(width || @renderer.width, height || @renderer.height)
    @world.populate Cell.new
  end

  def initial_pattern(*coordinates)
    coordinates.each do |x, y|
      cell = Cell.new(:alive)
      cell.x = x
      cell.y = y
      @world.set(cell)
    end
  end

  def run(rounds)
    render @world
    rounds.times do
      calculate_cycle
      apply
      render @world
    end
    @renderer.shutdown
  end

  private

    def initialize_renderer(renderer_type)
      renderer_class = renderer_type.to_s.split('_').map{ |p| p.capitalize }.join
      ['Renderer', renderer_class].inject(Object) { |o, c| o.const_get c}.new
    end

    def calculate_cycle
      @world.each do |cell|
        neighbours = @world.find_neighbours(cell)
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
      @world.each do |cell|
        cell.apply
      end
    end

    def render(world)
      @renderer.render world
    end
end