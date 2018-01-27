require_relative 'bitmap_image'
require_relative 'commands/base'
require_relative 'commands/change_pixel'
require_relative 'commands/clear'
require_relative 'commands/init'
require_relative 'commands/horizontal'
require_relative 'commands/vertical'

class BitmapEditor
  InvalidInputError = Class.new(StandardError)
  MAX_DIMENSION = 250
  def run(file)
    return puts 'please provide correct file' if file.nil? || !File.exist?(file)

    File.open(file).each_with_index do |line, index|
      line.chomp!
      fail_with_error('First command must be "I"', line) if index.zero? && line[0] != 'I'
      case line[0]
      when 'I' # I N M - Create a new M x N image with all pixels coloured white (O)
        @image = Commands::Init.new(line, @image).call
      when 'C' # C - Clears the table, setting all pixels to white (O)
        @image = Commands::Clear.new(line, @image).call
      when 'L' # 'L X Y C - Colours the pixel (X,Y) with colour C'
        @image = Commands::ChangePixel.new(line, @image).call
      when 'V' # V X Y1 Y2 C - Draw a vertical segment of colour C in column X between rows Y1 and Y2 (inclusive).
        @image = Commands::Vertical.new(line, @image).call
      when 'H' # H X1 X2 Y C - Draw a horizontal segment of colour C in row Y between columns X1 and X2 (inclusive).
        @image = Commands::Horizontal.new(line, @image).call
      when 'S' # S - Show the contents of the current image
        validate_line_s(line)
        @image.show
      else
        fail_with_error('Unrecognised command', line)
      end
    end
  rescue InvalidInputError => e
    warn(e)
  end

  private

  def validate_line_s(line)
    shared_validations(line, command: 'S', arg_count: 1)
  end

  def shared_validations(line, command:, arg_count:)
    arguments = line.split
    fail_with_error('Unrecognised command', line) unless arguments[0] == command
    fail_with_error('Wrong number of arguments', line) unless arguments.count == arg_count
  end

  def fail_with_error(message, line)
    raise(InvalidInputError, "ERROR - #{message}: '#{line}'")
  end
end
