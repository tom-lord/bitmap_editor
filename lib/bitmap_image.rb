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
    data.each { |row| puts row.join(' ') }
  end

  def change_pixel(x, y, colour)
    @data[y.to_i - 1][x.to_i - 1] = colour
  end
end
