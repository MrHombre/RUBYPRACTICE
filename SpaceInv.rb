# Sapce Invaders Clone Thing :B

# This creates a new window for the game
# Oh and were using Shoes GUI I'll put a link in the README

Shoes.app :width => 600, :height => 400, :resizable => false do
  background :black
end

 # Creating some invaders
 invaders_per_row = 10
 rows = 5

 @invaders = []
 @bullets = []

 # Now the invaders are going to be a bit big so that they'll fit on the screen
 invaders_girth = self.height / invaders_per_row / 2.4
 invaders_girth = invaders_girth * 2

 # Invaders move slow..you know at the start
 invaders_movement = self.width / 600

 # Lets center them!
 start_x = (self.width - invaders_space * invaders_per_row) / 2

 # Each of the invaders will be represented by a square...but it can be changed
 rows.times do |y|
   invaders_per_row.times do |x|
     ix = x * invaders_space + start_x
     iy = y * invaders_space + invaders_girth * 2
     @invaders << rect(ix, iy, invaders_girth, :fill => white)
   end
 end

 # The player is also a square to keep it simple
 px = (self.width - invaders_girth) / 2
 @player = rect px, self.height - invaders_girth * 2, invaders_girth, :fill => blue

 # The bullets are slim ovals
 @bullet = oval 0, 0, 4, 7, :fill => yellow
 @bullet.hide
