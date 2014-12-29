require 'world'
require 'cell'
require 'renderer/console'
require 'rules/conway'

class GolEngine
  def initialize(options = {})
    @renderer = get_renderer(options.fetch(:renderer, :console))
    @width    = options.fetch(:width, @renderer.width)
    @height   = options.fetch(:height, @renderer.height)
    include_rule options.fetch(:rule, :conway)
    @world  = World.new(@width, @height)
    @world.populate Cell.new
  end

  def read_pattern(file, translate_x = 0, translate_y = 0)
    raise "The file #{file} does not exist!" unless File.exists? file
    x = translate_x
    y = translate_y
    pattern = []
    File.open(file, 'r') do |f|
      f.each_line do |line|
        line.strip.chars.each do |char|
          pattern << [x, y] unless char.eql? '.'
          x += 1
        end
        x = translate_x
        y += 1
      end
    end
    initial_pattern pattern
  end

  def initial_pattern(coordinates)
    coordinates.each do |x, y|
      cell = @world.get(x, y)
      cell.state = :alive
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

    def get_renderer(renderer)
      get_constant(renderer, 'Renderer').new
    end

    def include_rule(rule)
      rule_module = get_constant(rule, 'Rules')
      extend rule_module
    end

    def get_constant(type, ns)
      klazz = type.to_s.split('_').map{ |p| p.capitalize }.join
      [ns, klazz].inject(Object) { |o, c| o.const_get c}
    rescue
      puts "Unknown constant #{ns}::#{klazz}. Try to include it before running the Game-of-Live-Engine."
      exit
    end

    def calculate_cycle
      neighbours = []
      @world.each do |cell|
        next if cell.is_dead?
        calculate_cell cell
        neighbours.concat cell.neighbours
      end
      neighbours.uniq.each do |c|
        calculate_cell c
      end
    end

    def calculate_cell(cell)
      alive_neighbours = cell.neighbours.reduce(0) { |count, neighbour| count += 1 if neighbour.is_alive?; count }
      execute_rule(cell, alive_neighbours)
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