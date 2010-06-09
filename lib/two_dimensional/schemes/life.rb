module TwoDimensional
  module Schemes    
    module Life
      extend self
      
      def game_of_life(size = 20)
        TwoDimensional::CellularAutomata.new(:seed => random_seed(size), :rule => rules)
      end
      
      def random_seed(size = 20)
        seed = TwoDimensional::State.new(MultiDimensionalArray.new(size, size))
        seed.each_index do |x, y|
          seed[x, y] = TwoDimensional::Cell.new(rand(2), seed, x, y)
        end
        
        seed
      end
      
      def rules
        TwoDimensional::Generation.new do |cell|
          if cell.alive?
            if (cell.neighbor_count < 2 || cell.neighbor_count > 3)
              Cell::Dead
            else
              Cell::Alive
            end
          else
            if cell.neighbor_count == 3
              Cell::Alive
            else
              Cell::Dead
            end
          end
        end
      end
      
    end
  end
end