module TwoDimensional  
  class State

    attr_accessor :grid
    
    def initialize(grid = nil)
      @grid = grid
    end
    
    def load_from_array(data)
      @grid = MultiDimensionalArray.new(data.length, data.length)
      for x in 0 ... data.length
        for y in 0 ... data.length
          @grid[x, y] = TwoDimensional::Cell.new(data[x][y], self, x, y)
        end
      end
    end
    
    def [](x, y)
      grid[x, y]
    rescue IndexError
      TwoDimensional::Cell.new(0, nil, nil, nil)
    end
    
    def []=(x, y, value)
      grid[x, y] = value
    end
    
    def neighbor_count(cell, options = {})
      steps = options[:steps] || 1
      
      sum = 0
      for x in (cell.x - steps .. cell.x + steps)
        for y in (cell.y - steps .. cell.y + steps)
          sum += self[x, y].value
        end
      end
      sum -= cell.value unless options[:include_self]
      
      sum
    end
        
    def each_index(&blk)
      for x in 0 ... @grid.dimensions[0]
        for y in 0 ... @grid.dimensions[1]
          blk.call(x, y)
        end
      end
    end
    
    def each(&blk)
      each_index { |x, y| blk.call(self[x, y]) }
    end
    
    def each_with_index(&blk)
      each_index { |x, y| blk.call(self[x, y], x, y) }
    end
    
    def update(x, y, value)
      self[x, y].value = value
    end
    
    def to_s
      output = ""
      
      for x in 0 ... @grid.dimensions[0]
        for y in 0 ... @grid.dimensions[1]
          output += self[x, y].to_s
        end
        output += "\n"
      end
      
      output
    end
    
  end
end