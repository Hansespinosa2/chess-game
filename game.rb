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
      a_pawn = Pawn.new(row=1,col=i,color=@guest_color,side='top',id=i, sym='p')
      @board.board_matrix[1][i] = a_pawn.sym
    end

    #put pawns on player side
    @board.board_matrix[6].each_with_index do |a_sym, i|
      a_pawn = Pawn.new(row=6,col=i,color=@player_color,side='bottom',id=i, sym='p')
      @board.board_matrix[6][i] = a_pawn.sym
    end
  end

  def display_game
    @board.display_board
  end





end
