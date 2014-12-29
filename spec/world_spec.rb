require 'rspec'
require 'world'
require 'cell'

RSpec.describe World do

  it 'should initialize with given width and height' do
    world = World.new(3, 7)
    expect(world.width).to be 3
    expect(world.height).to be 7
  end

  it 'should set and get at the given coordinates' do
    world = World.new(2, 2)
    cell = Cell.new(:alive)
    cell.x = 0
    cell.y = 1
    world.set(cell)
    expect(world.get(0, 1).is_alive?).to be(true)
    expect(world.get(0, 1).x).to be(0)
    expect(world.get(0, 1).y).to be(1)
  end

  describe 'populating' do
    before(:each) do 
      @world = World.new(3, 3)
      @world.populate(Cell.new(:alive))
    end

    it 'should populate the world with the prototype given' do
      expect(@world.get(0, 0).is_alive?).to be(true)
      expect(@world.get(0, 1).is_alive?).to be(true)
      expect(@world.get(0, 2).is_alive?).to be(true)
      expect(@world.get(1, 0).is_alive?).to be(true)
      expect(@world.get(1, 1).is_alive?).to be(true)
      expect(@world.get(1, 2).is_alive?).to be(true)
      expect(@world.get(2, 0).is_alive?).to be(true)
      expect(@world.get(2, 1).is_alive?).to be(true)
      expect(@world.get(2, 2).is_alive?).to be(true)
    end

    it 'should find all neighbours of a cell' do 
      cell = @world.get(1, 1)
      test_neighbours cell, [[0, 0], [1, 0], [2, 0], [1, 0], [1, 2], [2, 0], [2, 1], [2, 2]]
    end

    it 'should find all neighbours of the upper left corner cell' do
      cell = @world.get(0, 0)
      test_neighbours cell, [[1, 0], [1, 1], [0, 1], [2, 0], [2, 2], [0, 2], [2, 1], [1, 2]]
    end

    it 'should find all neighbours of the upper right corner cell' do
      cell = @world.get(2, 0)
      test_neighbours cell, [[1, 0], [1, 1], [2, 1], [0, 1], [2, 2], [0, 2], [1, 2], [0, 0]]
    end

    it 'should find all neighbours of the down left corner cell' do
      cell = @world.get(0, 2)
      test_neighbours cell, [[0, 1], [1, 1], [1, 2], [0, 0], [1, 0], [2, 2], [2, 1], [2, 0]]
    end

     it 'should find all neighbours of the down right corner cell' do
      cell = @world.get(2, 2)
      test_neighbours cell, [[2, 1], [1, 1], [1, 2], [0, 0], [1, 0], [2, 0], [0, 2], [0, 1]]
    end

    def test_neighbours(cell, expected_coords)
      neighbours = cell.neighbours
      expect(neighbours.length).to be(expected_coords.length)
      expected_coords.each do |x, y|
        expect(neighbours.find { |cell| cell.x == x && cell.y == y }).to be_a(Cell)
      end
    end
  end

  it 'should transform out of boundary coordinates for get' do
    world = World.new(2, 2)
    world.populate(Cell.new)
    expect(world.get(3, 0)).to satisfy { |cell| cell.x == 1 && cell.y == 0 }
    expect(world.get(0, 3)).to satisfy { |cell| cell.x == 0 && cell.y == 1 }
  end

  it 'should transform out of boundary coordinates for set' do
    world = World.new(2, 2)
    world.populate(Cell.new)
    cell = Cell.new()
    cell.x = 3
    cell.y = 0
    world.set(cell)
    expect(world.set(cell)).to satisfy { cell == world.get(1, 0);  }
    cell.x = 0
    cell.y = 3
    expect(world.set(cell)).to satisfy { cell == world.get(0, 1);  }
  end

  describe 'iterating' do 
    before(:each) do 
      @world = World.new(2, 2)
      @world.populate(Cell.new)
    end

    it 'should iterate over each cell' do
      i = 0
      @world.each do |cell|
        expect(cell).to be_a(Cell)
        i += 1
      end
      expect(i).to be(4)
    end

    it 'should iterate over each row' do
      i = 0
      @world.each_row do |row|
        expect(row).to be_an(Array)
        expect(row.length).to be(2)
        i += 1
      end
      expect(i).to be(2)
    end
  end
end