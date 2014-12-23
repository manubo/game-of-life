$: << File.dirname(__FILE__)

require 'cell'
require 'gol_engine'


engine = GolEngine.new(90, 40)
engine.initial_pattern([47, 16], [47, 18], [46, 18], [49, 17], [50, 18], [51, 18], [52, 18])
engine.run 300



