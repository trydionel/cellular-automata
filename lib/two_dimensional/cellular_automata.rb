module TwoDimensional  
  class CellularAutomata
  
    attr_accessor :rule, :states
  
    def initialize(options = {})
      @rule = options[:rule]
      @cache_size = options[:cache_size] || 30

      @states = []
      @states << options[:seed]
    end
    
    def run!(steps)
      steps.times { permute! }
    end
    
    def permute!
      states << permute(current_state)
      states.shift if states.length == @cache_size
    end
    
    def permute(state)
      rule.permute(state)
    end
    
    def current_state
      states.last
    end
    
    def to_s
      states.map(&:to_s).join("\n\n")
    end

  end
end