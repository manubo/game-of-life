class World
  attr_accessor :width, :height

  def initialize(width, height)
    @width  = width
    @height = height
    @grid   = Array.new(height) { Array.new(width)}
  end

  def populate(prototype)
    each do |x, y|
      set(x,y, prototype.new)
    end
  end

  def set(x, y, cell)
    raise 'Invalid coordinates' if !verify_coordinates(x, y)
    @grid[y][x] = cell
  end

  def get(x, y)
    raise 'Invalid coordinates' if !verify_coordinates(x, y)
    @grid[y][x]
  end

  def find_neighbours(x, y)
    neighbours = []
    for nx in (x - 1)..(x + 1) do
      if verify_coordinates(nx, y - 1)
        neighbours << get(nx, y - 1)
      end
      if verify_coordinates(nx, y + 1)
        neighbours << get(nx, y + 1)
      end
      if verify_coordinates(nx, y) && nx != x
        neighbours << get(nx, y)
      end
    end
    neighbours
  end

  def each
    for y in 0..(@height - 1)
      for x in 0..(@width - 1)
        yield x, y, get(x, y)
      end
    end
  end

  def each_row
    @grid.each { |row| yield row }
  end

  private

    def verify_coordinates(x, y)
      if x >= 0 && x < @width && y >= 0 && y < @height
        return true
      end
      false
    end
end
