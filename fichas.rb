class Ficha
  attr :row, :col, :color, :side, :sym
  def initialize(row=nil, col=nil, color='w',side='bottom', sym='()')
    @row = row
    @col = col
    @color = color
    @side = side
    @sym = sym
  end

  def move(delta_row=0,delta_col=0) #Row positive means to the right and column positive means up
    if self.can_move?(delta_row, delta_col) then
        @row = row - delta_row
        @col = @col + delta_col
    else
      p 'Illegaly move'
    end
  end

  def can_move?(row, col)
    true
  end

  def can_eat?(row, col)
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

  def can_move?(delta_row, delta_col)
    if delta_col != 0 then
      false
    end

    if @side=='bottom' then
      if !(delta_row == 1 or (delta_row == 2 and @row == 6)) then
        false
      end
    else
      if !(delta_row == -1 or (delta_row == -2 and @row == 1)) then
        false
      end
    end
    true
  end
end
