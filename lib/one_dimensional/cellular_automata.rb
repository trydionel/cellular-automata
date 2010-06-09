module OneDimensional
  class Rule
  
    attr_accessor :value
  
    def initialize(value)
      @value = value
    end
    
    def string
      @string ||= value.to_s(2).rjust(8, '0')
    end
  
    def chars
      @chars ||= string.chars.to_a
    end
  
  end

  class RuleTable
  
    attr_accessor :rule
  
    def initialize(rule)
      @rule = rule
    end
    
    def table
      @table ||= Hash[*%w[111 110 101 100 011 010 001 000].zip(rule.chars).flatten]
    end
  
    def [](index)
      table[index]
    end
  
  end

  class CellularAutomata
  
    attr_accessor :rule, :rules, :steps, :cells
  
    def initialize(options = {})
      @rule = Rule.new(options[:rule])
      @rules = RuleTable.new(@rule)
      @steps = options[:steps]

      @cells = []
      @cells << options[:seed]
    end
  
    def run!
      steps.times do
        cells << permute(cells.last)
      end
    end
  
    def to_s
      max_len = cells.last.length
      cells.map { |cell| cell.center(max_len, '0').tr('01', ' X') }.join("\n")
    end

  protected

    def permute(state)
      "00#{state}00".chars.each_cons(3).map do |neighborhood|
        rules[neighborhood.join]
      end.join
    end
  
  end
end

if __FILE__ == $0
  ca = OneDimensional::CellularAutomata.new(:rule => 18, :steps => 35, :seed => "1")
  ca.run!
  puts ca
end