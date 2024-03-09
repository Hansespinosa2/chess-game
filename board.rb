require_relative 'fichas.rb'
class Board
  attr_accessor :board_matrix, :ficha_hash
  def initialize(board_matrix = nil)
    if board_matrix.nil? then
      @board_matrix = 8.times.map { |i| 8.times.map { |j| "( )"} }

    else
      @board_matrix = board_matrix
    end
    @ficha_hash = self.initiate_ficha_hash
  end

  def move_piece(ficha)
    @board_matrix.each_with_index do |row, i|
      row.each_with_index do |sym, j|
        if sym == ficha.sym then
          @board_matrix[i][j] = "( )"
          break
        end
      end
    end
    @board_matrix[ficha.row][ficha.col] = ficha.sym

  end

  def display_board

    pp @board_matrix
  end

  def initiate_ficha_hash
    a_hash = {}
    @board_matrix.each_with_index do |row, i|
      row.each_with_index do |sym, j|
        a_hash[[i,j]] = nil
      end
    end
    a_hash
  end

end
