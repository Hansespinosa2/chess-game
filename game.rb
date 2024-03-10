require_relative 'board.rb'
require_relative 'fichas.rb'

class Game
  attr :board, :player_color, :guest_color
  def initialize(board = nil, player_color='w')
    if player_color== 'w' then
      @guest_color = 'b'
      @player_color = 'w'
    else
      @guest_color = 'w'
      @player_color = 'b'
    end

    if board == nil then
      @board = Board.new
      self.new_game

    else
      @board = board
    end

  end

  def new_game
    #Put pawns on opponent's side
    @board.board_matrix[1].each_with_index do |a_sym, i|
      a_pawn = Pawn.new(row=1,col=i,color=@guest_color,side='top')
      @board.board_matrix[1][i] = a_pawn.sym
      @board.ficha_hash[[1,i]] = a_pawn

    end

    #put pawns on player side
    @board.board_matrix[6].each_with_index do |a_sym, i|
      a_pawn = Pawn.new(row=6,col=i,color=@player_color,side='bottom')
      @board.board_matrix[6][i] = a_pawn.sym
      @board.ficha_hash[[6,i]] = a_pawn
    end

    #Put valuables on opponent's side
    @board.board_matrix[0].each_with_index do |a_sym, i|
      if i==0 or i==7 then
        a_val = Rook.new(0,i,@guest_color,side='top')
      elsif i==1 or i==6 then

        a_val = Knight.new(0,i,@guest_color,side='top')
      elsif i==2 or i==5 then

        a_val = Bishop.new(0,i,@guest_color,'top')
      elsif i==3 then

        a_val = Queen.new(0,i,@guest_color,'top')
      else

        a_val = King.new(0,i,@guest_color,'top')
      end
      @board.board_matrix[0][i] = a_val.sym
      @board.ficha_hash[[0,i]] = a_val
    end

    #Put valuables on player side
    @board.board_matrix[7].each_with_index do |a_sym, i|
      if i==0 or i==7 then
        a_val = Rook.new(7,i,@player_color,side='bottom')
      elsif i==1 or i==6 then

        a_val = Knight.new(7,i,@player_color,side='bottom')
      elsif i==2 or i==5 then

        a_val = Bishop.new(7,i,@player_color,'bottom')
      elsif i==3 then

        a_val = Queen.new(7,i,@player_color,'bottom')
      else

        a_val = King.new(7,i,@player_color,'bottom')
      end
      @board.board_matrix[7][i] = a_val.sym
      @board.ficha_hash[[7,i]] = a_val
    end

  end

  def display_game
    @board.display_board
  end

  def play
    while !(self.won?)
      self.display_game
      p "Input your move in format [row,col]->[row,col]:"
      input = gets.chomp #input is format
      if input == 'break' then
        break
      end

      old_pos = [input.split('')[1].to_i, input.split('')[3].to_i]
      new_pos = [input.split('')[8].to_i, input.split('')[10].to_i]


      if @board.ficha_hash[old_pos].nil? then
        print("Nothing on the tile #{old_pos}\n")
        next
      end
      if @board.ficha_hash[old_pos].valid_move?(*old_pos,*new_pos) and @board.can_eat?(old_pos,new_pos)
        @board.ficha_hash[old_pos].move_to(*new_pos)
      else
        print("#{@board.ficha_hash[old_pos].class.name}s cannot move that way \n")
        next
      end

      @board.ficha_hash[new_pos] = @board.ficha_hash[old_pos]
      @board.ficha_hash[old_pos] = nil
      @board.board_matrix[old_pos[0]][old_pos[1]] = '--'
      @board.board_matrix[new_pos[0]][new_pos[1]] = @board.ficha_hash[new_pos].sym
    end
  end

  def won?
    false
  end

end
