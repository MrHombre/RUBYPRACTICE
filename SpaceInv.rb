# Sapce Invaders Clone Thing :B

# This creates a new window for the game
# Oh and were using Shoes GUI I'll put a link in the README

Shoes.app :width => 600, :height => 400, :resizable => false do
  background :black
end

 # Creating some monster
 monster_per_row = 10
 rows = 5

 @monsters = []
 @bullets = []
