require 'curses'

module Renderer
  class Console
    def initialize(world)
      @world = world
      @window = Curses::Window.new(world.height, world.width, 0, 0)
      @window.refresh
      Curses::curs_set(0)
    end

    def render
      @window.clear
      box_window
      @world.each do |x, y, cell|
        if cell.is_alive?
          @window.setpos(y, x)
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