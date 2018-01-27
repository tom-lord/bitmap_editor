class BitmapImage
  attr_reader :height, :width, :data
  def initialize(height, width)
    @height = height.to_i
    @width = width.to_i
    clear
  end

  def clear
    @data = Array.new(height) { Array.new(width) { 'O' } }
  end

  def show
    data.each { |row| puts row.join }
  end

  def change_pixel(x, y, colour)
    @data[y.to_i - 1][x.to_i - 1] = colour
  end

  def change_vertical(column, row_start, row_end, colour)
    (row_start.to_i..row_end.to_i).each do |row|
      change_pixel(column.to_i, row, colour)
    end
  end

  def change_horizontal(row, column_start, column_end, colour)
    (column_start.to_i..column_end.to_i).each do |column|
      change_pixel(column, row.to_i, colour)
    end
  end
end
