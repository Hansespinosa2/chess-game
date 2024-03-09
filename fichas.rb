class Ficha
  attr :row, :col, :color, :side, :sym
  def initialize(row=nil, col=nil, color='w',side='bottom', sym='()')
    @row = row
    @col = col
    @color = color
    @side = side
    @sym = sym
  end

  def move_to(new_row,new_col) #Row positive means to the right and column positive means up
    if self.valid_move?(@row,@col, new_row,new_col) then

        @row = new_row
        @col = new_col
    else
      p 'Illegal move'
      return false
    end
  end

  def valid_move?(old_row,old_col, new_row,new_col)
    true
  end


end


class Pawn < Ficha
  attr :sym, :row, :col, :color, :side
  def initialize(row=nil, col=nil, color='w',side='bottom', id=0, sym='p')
    @row = row
    @col = col
    @color = color
    @side = side
    @id = id
    @sym = sym.to_s + color.to_s + id.to_s
  end

  def valid_move?(old_row,old_col, new_row,new_col)
    delta_col = new_col-old_col
    delta_row = new_row-old_row
    if delta_col.abs > 1 then
      return false
    end


    if @side=='bottom' then
      if !(delta_row == -1 or (delta_row == -2 and @row == 6)) then
        p delta_row
        p @row

        p 'failed not(change is 1 or (change is 2 and row is 6))'
        return false
      end
    else
      if !(delta_row == 1 or (delta_row == 2 and @row == 1)) then
        p 'failed not(change is -1 or (change is 2 and row is 1))'
        return false
      end
    end



    return true
  end
end
