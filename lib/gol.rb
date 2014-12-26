$: << File.dirname(__FILE__)

require 'cell'
require 'gol_engine'

engine = GolEngine.new
engine.initial_pattern([77, 26], [77, 28], [76, 28], [79, 27], [80, 28], [81, 28], [82, 28])
engine.run 1200
