require_relative 'fichas.rb'
class Board
  attr_accessor :board_matrix, :ficha_hash
  def initialize(board_matrix = nil)
    if board_matrix.nil? then
      @board_matrix = 8.times.map { |i| 8.times.map { |j| "--"} }

    else
      @board_matrix = board_matrix
    end
    @ficha_hash = self.initiate_ficha_hash
  end



  def display_board
    puts "\n"
    pp @board_matrix
    puts "\n"
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

  def can_eat?(eater_pos,eaten_pos)
    eater = @ficha_hash[eater_pos]
    eaten = @ficha_hash[eaten_pos]
    if eaten.nil? then
      if eater.sym[0] == 'p' and (eater_pos[1] - eaten_pos[1]).abs == 1 then
        return false
      end

      unless self.crossed?(eater_pos,eaten_pos) and eater.sym[0] != 'h' then
        return true
      else
        return false
      end

    elsif eater.color == eaten.color then
      return false
    elsif eaten.sym[0] == 'k' then
      return false
    elsif eater.sym[0] == 'p' and (eater.col-eaten.col).abs == 0 #return false if a pawn tries to take something straight on
      return false
    end

    if self.crossed?(eater_pos,eaten_pos) and eater.sym[0] != 'h' then
      return false
    end


    return true


  end

  def crossed?(eater_pos, eaten_pos)
    min_row = [eater_pos[0],eaten_pos[0]].min
    max_row = [eater_pos[0],eaten_pos[0]].max
    min_col = [eater_pos[1],eaten_pos[1]].min
    max_col = [eater_pos[1],eaten_pos[1]].max

    for row in (min_row..max_row).to_a
      for col in (min_col..max_col).to_a
        if !ficha_hash[[row,col]].nil? and ([row,col] != eater_pos and [row,col] != eaten_pos) then
          return true
        end

      end
    end
    return false
  end

end
