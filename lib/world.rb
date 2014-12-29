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
    each do |cell|
      set_neighbours(cell)
    end
  end

  def set(cell)
    coords = transform_coordinates(cell.x, cell.y)
    cell.x = coords[0]
    cell.y = coords[1]
    @grid[cell.y][cell.x] = cell
  end

  def get(x, y)
    coords = transform_coordinates(x, y)
    @grid[coords[1]][coords[0]]
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
    def transform_coordinates(x, y)
      [(x + @width) % @width, (y + @height) % @height]
    end

    def set_neighbours(cell)
      neighbours = []
      x = cell.x
      y = cell.y
      [x - 1, x, x + 1].each do |nx|
        neighbours << get(nx, y - 1)
        neighbours << get(nx, y + 1)
        neighbours << get(nx, y) unless nx == x
      end
      cell.neighbours = neighbours
    end
end
