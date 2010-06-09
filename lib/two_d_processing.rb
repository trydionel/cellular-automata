require File.join(File.dirname(__FILE__), 'two_dimensional')
require File.join(File.dirname(__FILE__), 'two_dimensional', 'schemes', 'life')

class TwoDProcessing < Processing::App
  load_library :opengl

  def setup
    library_loaded?(:opengl) ? render_mode(OPENGL) : render_mode(P3D)
    # frame_rate 1
    @size = 50
    
    @rect_size = {}
    @rect_size[:width] = width / @size
    @rect_size[:height] = height / @size
        
    @ca = TwoDimensional::Schemes::Life.game_of_life(@size)
  end
  
  def draw    
    background 0
    
    @ca.states.last.each_with_index do |cell, x, y|
      fill ( cell.alive? ? 255 : 0 )
      x_pos = x * @rect_size[:width]
      y_pos = y * @rect_size[:height]
      rect x_pos, y_pos, x_pos + 100, y_pos + 100
    end

    @ca.permute!
  end
end

TwoDProcessing.new :width => 500, :height => 500