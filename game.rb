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
