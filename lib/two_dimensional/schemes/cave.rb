module TwoDimensional
  module Schemes    
    module Cave
      extend self
      
      def generate!(size = { :x => 50, :y => 50 })
        ca = TwoDimensional::CellularAutomata.new(:seed => random_seed(size, 0.5), :rule => first_generation)
        ca.run!(4)
        ca.rule = second_generation
        ca.run!(3)
        
        ca
      end
      
      def random_seed(size = { :x => 50, :y => 50 }, percent_walls = 0.4)
        seed = TwoDimensional::State.new(MultiDimensionalArray.new(size[:x], size[:y], :rotational_indices => false))
        seed.each_index do |x, y|
          seed[x, y] = TwoDimensional::Cell.new(rand < percent_walls ? 1 : 0, seed, x, y)
        end
        
        seed
      end
      
      def first_generation
        TwoDimensional::Generation.new do |cell|
          if cell.neighbor_count(:include_self => true) >= 5 || cell.neighbor_count(:steps => 2, :include_self => true) <= 1
            Cell::Alive
          else
            Cell::Dead
          end
        end        
      end

      def second_generation
        TwoDimensional::Generation.new do |cell|
          if cell.neighbor_count(:include_self => true) >= 5
            Cell::Alive
          else
            Cell::Dead
          end
        end        
      end
      
    end
  end
end