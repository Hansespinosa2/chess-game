require_relative 'fichas.rb'
class Board
  attr :board_matrix
  def initialize(board_matrix = nil)
    if board_matrix.nil? then
      @board_matrix = 8.times.map { |i| 8.times.map { |j| "T#{i}#{j}"} }
    else
      @board_matrix = board_matrix
    end
  end

  def move_piece(ficha)
    @board_matrix.each_with_index do |row, i|
      row.each_with_index do |sym, j|
        if sym == ficha.sym then
          @board_matrix[i][j] = "T#{i}#{j}"
          break
        end
      end
    end
    @board_matrix[ficha.row][ficha.col] = ficha.sym

  end

  def display_board
    pp @board_matrix
  end

end
