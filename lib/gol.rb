$: << File.dirname(__FILE__)

require 'cell'
require 'gol_engine'

engine = GolEngine.new
engine.read_pattern('patterns/grower.txt', 100, 30)
engine.run 1000
