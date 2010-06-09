module TwoDimensional
  class Cell
    
    Alive = 1
    Dead = 0
    
    attr_accessor :value, :x, :y
    
    def initialize(value, parent, x, y)
      @value = value
      @parent = parent
      @x = x
      @y = y
    end
    
    def neighbor_count(options = {})
      @parent.neighbor_count(self, options)
    end
    
    def alive?
      @value == Alive
    end
    
    def dead?
      !alive?
    end
    
    def to_s
      alive? ? "X" : " "
    end
    
  end
end