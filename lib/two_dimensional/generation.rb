module TwoDimensional
  class Generation
    
    attr_accessor :block
    
    def initialize(&blk)
      @block = blk
    end
    
    def permute(state)
      new_state = state.deep_copy
      state.each_with_index do |cell, x, y|
        new_state[x, y].value = block.call(cell)
      end
      
      new_state
    end
    
  end
end