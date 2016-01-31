# Grwoing Bubbles when the mous move around the app window

# Array of x,y coordinates for bubbles
bubbles = [[0,0]] * 30

# Bubbles App
Shoes.app :width => 537, :height => 500 do
  # This is going to be slow about 24 frames/ second
  animate(24) do
    bubbles.shift
    bubbles << self.mouse[1,2]
  end
end
