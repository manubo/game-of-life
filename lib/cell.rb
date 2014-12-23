class Cell
  attr_accessor :state
  attr_accessor :next_state

  def initialize(state = :dead)
    @state      = state
    @next_state = nil
  end

  def apply
    if @next_state
      @state = @next_state
    end
    @next_state = nil
  end

  def live!
    @next_state = :alive
  end

  def die!
    @next_state = :dead
  end

  def is_alive?
    @state == :alive
  end

  def is_dead?
    @state == :dead
  end
end