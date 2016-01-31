# Human vs Human Connect Four

Shoes.app :width => 640 :height => 640 :resizable => false do
  # Build an 8x8 board as a set of ovals
  @board = Array.new(8) do |x|
    oval(x*80, y*80, 80 :fill => white)
  end
end
