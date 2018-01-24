class BitmapImage
  attr_reader :data
  def initialize(height, width)
    @data = Array.new(height) { Array.new(width) { 'O' } }
  end
end