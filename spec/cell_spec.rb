require 'rspec'
require 'cell'

RSpec.describe Cell do
  before(:each) do
    @cell = Cell.new
  end

  it 'should be initialized dead by default' do
    expect(@cell.state).to equal(:dead)
  end

  it 'should be initialized with the passed state' do
    cell = Cell.new(:dead)
    expect(cell.state).to equal(:dead)
    cell = Cell.new(:alive)
    expect(cell.state).to equal(:alive)
  end

  it 'should not changed state' do
    @cell.apply
    expect(@cell.state).to equal(:dead)
  end

  it 'should changed state to alive' do
    @cell.live!
    expect(@cell.state).to equal(:dead)
    @cell.apply
    expect(@cell.state).to equal(:alive)
  end

  it 'should changed state to dead' do
    @cell.state = :alive
    expect(@cell.state).to equal(:alive)
    @cell.die!
    @cell.apply
    expect(@cell.state).to equal(:dead)
  end

  it 'should tell whether it is dead' do
    expect(@cell.is_dead?).to be(true)
    expect(@cell.is_alive?).to be(false)
  end

  it 'should tell whether it is alive' do
    @cell.state = :alive
    expect(@cell.is_alive?).to be(true)
    expect(@cell.is_dead?).to be(false)
  end
end