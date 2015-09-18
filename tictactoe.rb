class Tic

  def initialize
    #map possible wins
    @columns = [
      [:a1,:a2,:a3],
      [:b1,:b2,:b3],
      [:c1,:c2,:c3],

      [:a1,:b1,:c1],
      [:a2,:b2,:c2],
      [:a3,:b3,:c3],

      [:a1,:b2,:c3],
      [:c1,:b2,:a3]
    ]

    @cpu = rand() > 0.5 ? 'X' : 'O'
    @user = @cpu == 'X' ? 'O' : 'X'

    @cpu_name = "The Master"
    put_line
    puts "\n TIC TAC TOE WHO WILL WIN"
    print "\n What is your name? "
    STDOUT.flush
    @user_name = gets.chomp
    put_bar

    @user_score = 0
    @cpu_score = 0

    start_game(@user == 'X')
  end

  def start_game(user_goes_first)
    #making the tic tac toe slots
    @places = {
      a1:" ",a2:" ",a3:" ",
      b1:" ",b2:" ",b3:" ",
      c1:" ",c2:" ",c3:" "
    }

    #Who goes first
    if user_goes_first
      user_turn
    else
      cpu_turn
    end
  end

#simple restart
  def restart_game(user_goes_first)
    (1...20).each{|i| put_bar}
    start_game(user_goes_first)
  end

  def put_line
    puts ("-" * 80)
  end

  def put_bar
    puts ("#" * 80)
    puts ("#" * 80)
  end

#The places left that would make a draw game??
  def draw_game
    puts ""
    puts "Wins: #{@cpu_name}:#{@cpu_score} #{@user_name}:#{@user_score}"
    puts ""
    puts " #{@cpu_name}: #{@cpu}"
    puts "#{@user_name}: #{@user}"
    puts ""
    puts "     a   b   c"
    puts ""
    puts " 1   #{@places[:a1]} | #{@places[:b1]} | #{@places[:c1]} "
    puts "    --- --- ---"
    puts " 2   #{@places[:a2]} | #{@places[:b2]} | #{@places[:c2]} "
    puts "    --- --- ---"
    puts " 3   #{@places[:a3]} | #{@places[:b3]} | #{@places[:c3]} "
  end

  def cpu_turn
    move = cpu_find_move
    @places[move] = @cpu
    put_line
    puts "#{@cpu_name} marks #{move.to_s.upcase}"
    check_game(@user)
  end

  def cpu_find_move #this ned to be coded better repeating myself

    #seeing if the cpu can win
    #also seeing if any cloumns already have 2 moves by the cpu
    @columns.each do |column|
      if times_in_column(column, @cpu) == 2
        return empty_in_column column
      end
    end

    #seeing if user can win also asme as above checking
    @columns.each do |column|
      if times_in_column(column, @user) == 2
        return empty_in_column column
      end
    end

    #seeing fi any columns already have 1 move made by the cpu
    @columns.each do |column|
      if times_in_column(column, @cpu) == 1
        return empty_in_column column
      end
    end

    #if no ideal spot(strategic) found just find a random empty spot
    k = @places.keys;
    i = rand(k.length)
    if @places[k[i]] == " "
      return k[i]
    else
      #this is if not ideal spot is found. It finds the first empty slot
      @places.each {|k,v| return k if v == " "}
    end
  end

  def times_in_column arr, item
    times = 0
    arr.each do |i|
      times += 1 if @places[i] == item
      unless @places[i] == item || @places[i] == " "
        #code above is doning something I still not quiet to sure of, but it working so yay StackOverflow
        return 0
      end
    end
    times
  end

  def empty_in_column arr
    arr.each do |i|
      if @places[i] == " "
        return i
      end
    end
  end

  def user_turn
    put_line
    puts "\n TIC TAC TOE"
    draw_game
    print "\n #{@user_name}, please make a move or type 'exit' to quit: "
    STDOUT.flush
    input =gets.chomp.downcase.to_sym
    put_bar
    if input.length == 2
      a = input.to_s.split("")
      if(['a','b','c'].include? a[0])
        if(['1','2','3'].include? a[1])
          if @places[input] == " "
            @places[input] = @user
            put_line
            puts "#{@user_name} marks #{input.to_s.upcase}"
            check_game(@cpu)
          else
            wrong_move
          end
        else
          wrong_input
        end
      else
        wrong_input
      end
    else
      wrong_input unless input == :exit
    end
  end

  def wrong_input
    put_line
    puts " Please specify a move with 'A1', 'B3', 'C2' etc."
    user_turn
  end

  def wrong_move
    put_line
    puts " You ned to choose an empty slot"
    user_turn
  end

  def moves_left
    @places.values.select{ |v| v == " "}.length
  end

  def check_game(next_turn)

    game_over = nil

    @columns.each do |column|
      if times_in_column(column, @cpu) == 3
        put_line
        draw_game
        put_line
        puts ""
        puts " Game Over -- #{@cpu_name} WINS!!!\n"
        game_over = true
        @cpu_score += 1
        ask_to_play_again(false)
      end

      if times_in_column(column, @user) == 3
        put_line
        draw_game
        put_line
        puts ""
        puts " Game Over -- #{@user_name} WINS!!!\n"
        game_over = true
        @cpu_score += 1
        ask_to_play_again(false)
      end

      unless game_over
        if(moves_left > 0)
          if(next_turn == @user)
            user_turn
          else
            cpu_turn
          end
        else
          put_line
          draw_game
          put_line
          puts ""
          puts "Game Over -- DRAW!!\n"
          ask_to_play_again(rand() > 0.5)
        end
      end
    end

    def ask_to_play_again(user_goes_first)
      print "Play Again? (Yn):"
      STDOUT.flush
      response = gets.chomp.downcase
      case response
      when "y" then
        restart_game(user_goes_first)
      when "yes" then
        restart_game(user_goes_first)
      when "n" then #it's doing nothin
      when "no" then #same as before
      else ask_to_play_again(user_goes_first)
      end
    end


end

game = Tic.new
end
