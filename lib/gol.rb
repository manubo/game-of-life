$: << File.dirname(__FILE__)

require 'cell'
require 'gol_engine'

engine = GolEngine.new(140, 75)
engine.initial_pattern([57, 36], [57, 38], [56, 38], [59, 37], [60, 38], [61, 38], [62, 38])
engine.run 1000



