require 'curses'

module Renderer
  class Console
    attr_reader :width, :height
    attr_writer :world

    def initialize
      Curses.init_screen
      @width  = Curses.cols
      @height = Curses.lines
      @window = Curses::Window.new(@height, @width, 0, 0)
      Curses::curs_set(0)
      @window.refresh
    end

    def render(world)
      sleep(0.012)
      @window.clear
      box_window
      world.each do |cell|
        if cell.is_alive?
          @window.setpos(cell.y, cell.x)
          @window.addstr("\u273A".encode('utf-8'))
          @window.refresh
        end
      end
    end

    def shutdown
      @window.close
    end

    private
      def box_window
        @window.box('|', '-')
      end
  end
end