class BitmapImage
  attr_reader :height, :width, :data
  def initialize(height, width)
    @height = height
    @width = width
    clear
  end

  def clear
    @data = Array.new(height.to_i) { Array.new(width.to_i) { 'O' } }
  end

  def show
    data.each { |row| puts row.join(' ') }
  end

  def change_pixel(x, y, colour)
    @data[y.to_i - 1][x.to_i - 1] = colour
  end
end
