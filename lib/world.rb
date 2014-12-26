class World
  attr_accessor :width, :height

  def initialize(width, height)
    @width  = width
    @height = height
    @grid   = Array.new(height) { Array.new(width)}
  end

  def populate(prototype)
    for y in 0..(@height - 1)
      for x in 0..(@width - 1)
        cell = prototype.clone
        cell.x = x
        cell.y = y
        set(cell)
      end
    end
  end

  def set(cell)
    raise 'Invalid coordinates' unless verify_coordinates(cell.x, cell.y)
    @grid[cell.y][cell.x] = cell
  end

  def get(x, y)
    raise 'Invalid coordinates' unless verify_coordinates(x, y)
    @grid[y][x]
  end

  def find_neighbours(cell)
    neighbours = []
    x = cell.x
    y = cell.y
    [x - 1, x, x + 1].each do |nx|
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

  def each_row
    @grid.each { |row| yield row }
  end

  def each
    each_row do |row|
      row.each do |cell|
        yield cell
      end
    end
  end

  private
    def verify_coordinates(x, y)
      if x >= 0 && x < @width && y >= 0 && y < @height
        return true
      end
      false
    end
end
