class TicTacToe
  def initialize(player1, player2)
    @player1 = player1
    @player2 = player2
    @counter = 1

    @player1_moves = []
    @player1_rows = []
    @player1_columns = []

    @player2_moves = []
    @player2_rows = []
    @player2_columns = []

    @player1_row_tally = @player1_rows.tally
    @player1_column_tally = @player1_columns.tally

    @player2_row_tally = @player2_rows.tally
    @player2_column_tally = @player2_columns.tally

    @all_moves = []
    @accepted_moves = [%w[a 1], %w[a 2], %w[a 3], %w[b 1], %w[b 2], %w[b 3], %w[c 1], %w[c 2],
                       %w[c 3]]
    @diag_combo1 = [%w[a 1], %w[b 2], %w[c 3]]
    @diag_combo2 = [%w[a 3], %w[b 2], %w[c 1]]
  end

  def turn
    @player_turn = if @counter.even?
                     @player2
                   else
                     @player1
                   end
    @player_turn
  end

  def move
    @player_up = turn

    puts "#{@player_up}, enter your move"

    @move = gets.chomp.split('')

    if @all_moves.include?(@move) || @accepted_moves.none? { |accepted_move| (@move - accepted_move).empty? }
      puts "Sorry, you can't make that move, #{@player_up}.\nEnter an acceptable move that has not been used."
    else

      @column = @move[0]
      @row = @move[1]

      puts "#{@player_up}, your move was #{@column}#{@row}"
      @counter += 1

      store_move
    end
  end

  def store_move
    # push each move to a player's array
    @all_moves.push(@move)

    if @player_up == @player1
      @player1_rows.push(@move[0])
      @player1_columns.push(@move[1])
      @player1_moves.push(@move)
    else
      @player2_rows.push(@move[0])
      @player2_columns.push(@move[1])
      @player2_moves.push(@move)
    end
  end

  def winner

    if (@diag_combo1 - @player1_moves).empty? || (@diag_combo2 - @player1_moves).empty? || @player1_row_tally.has_value?(3) || @player1_column_tally.has_value?(3)
      puts "#{@player1} wins!"
      'game over'

    elsif (@diag_combo1 - @player2_moves).empty? || (@diag_combo2 - @player2_moves).empty? || @player2_row_tally.has_value?(3) || @player2_column_tally.has_value?(3)
      puts "#{@player2} wins!"
      'game over'

    elsif @counter == 10
      puts 'No winners here!'
      'game over'
    end
  end

  def play
    while @counter < 10
      move # calling this function; formatter keeps taking off parentheses
      #   store_move
      print "player1_moves: #{@player1_moves} \n"
      print "player2_moves: #{@player2_moves} \n"

      return if winner == 'game over'

    end
  end
end

game = TicTacToe.new('Player1', 'Player2')
# game = TicTacToe.new
game.play
