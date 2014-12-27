$: << File.dirname(__FILE__)

require 'cell'
require 'gol_engine'

engine = GolEngine.new
engine.read_pattern('patterns/puff-suppresor.txt', 80, 12)
engine.run 1000
