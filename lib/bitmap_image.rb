class BitmapImage
  attr_reader :data
  def initialize(height, width)
    @data = Array.new(height.to_i) { Array.new(width.to_i) { 'O' } }
  end

  def show
    data.each { |row| puts row.join(' ') }
  end
end
