module Rules
  module Conway
    def execute_rule(cell, alive_neighbours)
      if cell.is_dead? && alive_neighbours == 3
        cell.live!
      end
      if cell.is_alive? && (alive_neighbours < 2 || alive_neighbours > 3)          
        cell.die!
      end
    end
  end
end