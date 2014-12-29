$: << File.dirname(__FILE__)

require 'cell'
require 'gol_engine'

engine = GolEngine.new
engine.read_pattern('patterns/puffer.txt', 100, 65)
engine.run 1000
