require 'spec_helper'
require 'one_dimensional/cellular_automata'

describe OneDimensional::CellularAutomata do
  
  it "should produce the expected result" do
    ca = OneDimensional::CellularAutomata.new(:rule => 18, :steps => 10, :seed => "1")
    ca.run!
    ca.cells.last.should == "100010000000000010001"
  end
  
end
