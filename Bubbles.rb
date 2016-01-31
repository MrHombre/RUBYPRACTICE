# Grwoing Bubbles when the mouse move around the app window

# Array of x,y coordinates for bubbles
bubbles = [[0,0]] * 30

# Bubbles App
Shoes.app :width => 537, :height => 500 do
  # This is going to be slow about 24 frames/ second
  animate(24) do
    bubbles.shift
    bubbles << self.mouse[1,2]

    # This is for the pink-ish linescan which can be changed
    clear do
      (500/5).times do |i|
        strokewidth 2
        stroke rgb(1.0. 0.5, 1.0, 1.0)
        line 0, i * 5, 537, i * 5
      end
    end
  end
end
