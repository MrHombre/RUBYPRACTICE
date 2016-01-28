# Sapce Invaders Clone Thing :B

# This creates a new window for the game
# Oh and were using Shoes GUI I'll put a link in the README

Shoes.app :width => 600, :height => 400, :resizable => false do
  background :black

  # Creating some invaders
  invaders_per_row = 10
  rows = 5

  @invaders = []
  @bullets = []

  # Now the invaders are going to be a bit big so that they'll fit on the screen
  invader_girth = self.height / invaders_per_row / 2.4
  invader_space = invader_girth * 2

  # Invaders move slow..you know at the start
  invader_movement = self.width / 600

  # Lets center them!
  start_x = (self.width - invader_space * invaders_per_row) / 2

  # Each of the invaders will be represented by a square
  rows.times do |y|
    invaders_per_row.times do |x|
      ix = x * invader_space + start_x
      iy = y * invader_space + invader_girth * 2
      @invaders << rect(ix, iy, invader_girth, :fill => white)
    end
  end

  # The player is also a square to keep it simple
  px = (self.width - invader_girth) / 2
  @player = rect px, self.height - invader_girth * 2, invader_girth, :fill => blue

  # The bullets are slim ovals
  @bullet = oval 0, 0, 4, 7, :fill => yellow
  @bullet.hide

  # The player is not moving
  @moving = 0

  every 3 do
    #Find a invader to shoot at teh player
    i = @invaders[rand(@invaders.size)]

    # We center the bullet
    bx = i.left + invader_girth / 2 + 5
    by = i.top + invader_girth - 5

    # BOOM! FIRE!!!
    @bullets << oval(bx, by, 10, :fill => green)
  end

  @anim = animate 200  do
    change_directions = false

    # We want the invaders to only go left and right
    @invaders.each do |i|
      i.move i.left + invader_movement, i.top

      # Hitting a wall blowing up the game?! Here a fix
      if i.left + invader_girth + invader_movement > self.width || i.left + invader_movement < 0
        change_directions = true
      end

      # If the invader reaches the bottom
      if i.top + invader_girth > @player.top
        @anim.stop and alert("You win nothing!")
        break
      end
    end

    # Kill all Invaders?
    if @invaders.size == 0
      @anim.stop and alert("You win...but still get nothing!")
    end

    # Move the invaders down, increase speed, and change directions OH MY GOD!!
    if change_directions
      invader_movement = -invader_movement * 1.1

      # The invaders should be going down toward the player
      @invaders.each do |i|
        i.move i.left, i.top + invader_girth
      end
    end

    # Moving the player
    @player.move @player.left + @moving, @player.top

    # Moving the bullet
    @bullet.move @bullet.left, @bullet.top - 10

    # Moving the invaders bullets
    @bullets.each do |b|
      b.move b.left, b.top + 7

      # Check to see if a bullet hit the player or missed
      if b.top > @player.top
        if b.left + 5 > @player.left and b.left + 5 < @player.left + invader_girth
          # Bullet hit player
          @anim.stop and alert("You were shot! @.@") and break
        end
        @bullets.delete b and b.hide
      end
    end

    # Bullet hit Invaders?
    @invaders.each do |i|
      if @bullet.left + 2 > i.left and @bullet.left + 2 < i.left + invader_girth
        if @bullet.top + 3 > i.top and @bullet.top + 3 < i.top + invader_girth
          @bullet.move 0, 0 and @bullet.hide
          @invaders.delete i and i.hide
        end
      end
    end
  end

  # Respond to key press to move player and shoot
  keypress do |key|
    if key == :left
      @moving = -4
    elsif key == :right
      @moving = 4
    elsif key == " "
      @bullet.move @player.left + invader_girth / 2 - 2, @player.top
      @bullet.show
    end
  end
end
