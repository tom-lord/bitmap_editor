require 'bitmap_image'
class BitmapEditor
  InvalidInputError = Class.new(StandardError)
  def run(file)
    return puts 'please provide correct file' if file.nil? || !File.exist?(file)

    File.open(file).each_with_index do |line, index|
      line.chomp!
      fail_with_error('First command must be "I"', line) if index.zero? && line[0] != 'I'
      case line[0]
      when 'I' # I N M - Create a new M x N image with all pixels coloured white (O)
        validate_line_i(line)
        @image = BitmapImage.new(*line.split[1..-1])
      when 'C' # C - Clears the table, setting all pixels to white (O)
        validate_line_c(line)
        @image.clear
      when 'L' # 'L X Y C - Colours the pixel (X,Y) with colour C'
        validate_line_l(line)
        @image.change_pixel(*line.split[1..-1])
      when 'V' # V X Y1 Y2 C - Draw a vertical segment of colour C in column X between rows Y1 and Y2 (inclusive).
        validate_line_v(line)
        @image.change_vertical(*line.split[1..-1])
      when 'H' # H X1 X2 Y C - Draw a horizontal segment of colour C in row Y between columns X1 and X2 (inclusive).
        validate_line_h(line)
        @image.change_horizontal(*line.split[1..-1])
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

  def validate_line_i(line)
    shared_validations(line, command: 'I', arg_count: 3)
    arguments = line.split
    arguments[1..2].each do |coordinate|
      unless coordinate =~ /\A\d{1,3}\z/ && coordinate.to_i.between?(1, 250)
        fail_with_error('Input invalid or out of range (1-250)', line)
      end
    end
  end

  def validate_line_c(line)
    shared_validations(line, command: 'C', arg_count: 1)
  end

  def validate_line_l(line)
    shared_validations(line, command: 'L', arg_count: 4)
    arguments = line.split
    arguments[1..2].each do |coordinate|
      unless coordinate =~ /\A\d{1,3}\z/ && coordinate.to_i.between?(1, 250)
        fail_with_error('Input invalid or out of range (1-250)', line)
      end
    end
    fail_with_error('Invalid colour', line) unless arguments[3] =~ /\A[A-Z]\z/
    fail_with_error('Outside current canvas', line) if arguments[1].to_i > @image.width
    fail_with_error('Outside current canvas', line) if arguments[2].to_i > @image.height
  end

  def validate_line_v(line)
    shared_validations(line, command: 'V', arg_count: 5)
    arguments = line.split
    arguments[1..3].each do |coordinate|
      unless coordinate =~ /\A\d{1,3}\z/ && coordinate.to_i.between?(1, 250)
        fail_with_error('Input invalid or out of range (1-250)', line)
      end
    end
    fail_with_error('Invalid colour', line) unless arguments[4] =~ /\A[A-Z]\z/
    fail_with_error('Outside current canvas', line) if arguments[1].to_i > @image.width
    fail_with_error('Outside current canvas', line) if arguments[3].to_i > @image.height
    fail_with_error('Invalid range', line) if arguments[2].to_i > arguments[3].to_i
  end

  def validate_line_h(line)
    shared_validations(line, command: 'H', arg_count: 5)
    arguments = line.split
    arguments[1..3].each do |coordinate|
      unless coordinate =~ /\A\d{1,3}\z/ && coordinate.to_i.between?(1, 250)
        fail_with_error('Input invalid or out of range (1-250)', line)
      end
    end
    fail_with_error('Invalid colour', line) unless arguments[4] =~ /\A[A-Z]\z/
    fail_with_error('Outside current canvas', line) if arguments[1].to_i > @image.height
    fail_with_error('Outside current canvas', line) if arguments[3].to_i > @image.width
    fail_with_error('Invalid range', line) if arguments[2].to_i > arguments[3].to_i
  end

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
