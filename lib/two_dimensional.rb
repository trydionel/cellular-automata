require File.join(File.dirname(__FILE__), 'core', 'object')
require File.join(File.dirname(__FILE__), 'core', 'multi_dimensional_array')
require File.join(File.dirname(__FILE__), 'two_dimensional', 'cell')
require File.join(File.dirname(__FILE__), 'two_dimensional', 'state')
require File.join(File.dirname(__FILE__), 'two_dimensional', 'generation')
require File.join(File.dirname(__FILE__), 'two_dimensional', 'cellular_automata')

require File.join(File.dirname(__FILE__), 'two_dimensional', 'schemes', 'life')
require File.join(File.dirname(__FILE__), 'two_dimensional', 'schemes', 'cave')

if __FILE__ == $0
  scheme = ARGV[0] || "life"
  
  case scheme
  when "life"
    ca = TwoDimensional::Schemes::Life.game_of_life
    ca.run!(15)
    puts ca
  when "cave"
    ca = TwoDimensional::Schemes::Cave.generate! :x => 20, :y => 64
    map = ca.current_state.to_s
    puts "X" * 66 + "\nX" + map[0..map.length - 2].gsub("\n", "X\nX") + "X\n" + "X" * 66
  end
end