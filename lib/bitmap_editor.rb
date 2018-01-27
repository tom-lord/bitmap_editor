require_relative 'bitmap_image'
require_relative 'commands/base'
require_relative 'commands/change_pixel'
require_relative 'commands/clear'
require_relative 'commands/init'
require_relative 'commands/horizontal'
require_relative 'commands/show'
require_relative 'commands/vertical'

class BitmapEditor
  InvalidInputError = Class.new(StandardError)
  MAX_DIMENSION = 250
  COMMANDS = {
    # I M N - Create a new M x N image with all pixels coloured white (O)
    'I' => Commands::Init,
    # C - Clears the table, setting all pixels to white (O)
    'C' => Commands::Clear,
    # L X Y C - Colours the pixel (X,Y) with colour C
    'L' => Commands::ChangePixel,
    # V X Y1 Y2 C - Draw a vertical segment of colour C in column X between rows Y1 and Y2 (inclusive).
    'V' => Commands::Vertical,
    # H X1 X2 Y C - Draw a horizontal segment of colour C in row Y between columns X1 and X2 (inclusive).
    'H' => Commands::Horizontal,
    # S - Show the contents of the current image
    'S' => Commands::Show
  }.freeze

  def run(file)
    return puts 'please provide correct file' if file.nil? || !File.exist?(file)

    File.open(file).each_with_index do |line, index|
      line.chomp!
      if index.zero? && line[0] != 'I'
        fail_with_error('First command must be "I"', line)
      elsif COMMANDS.keys.include?(line[0])
        @image = COMMANDS[line[0]].new(line, @image).call
      else
        fail_with_error('Unrecognised command', line)
      end
    end
  rescue InvalidInputError => e
    warn(e)
  end

  private

  def fail_with_error(message, line)
    raise(InvalidInputError, "ERROR - #{message}: '#{line}'")
  end
end
