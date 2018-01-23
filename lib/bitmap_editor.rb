class BitmapEditor
  InvalidInputError = Class.new(StandardError)
  def run(file)
    return puts 'please provide correct file' if file.nil? || !File.exist?(file)

    File.open(file).each do |line|
      line = line.chomp
      case line[0]
      when 'I'
        validate_line_i(line)
        # @image = BitmapImage.new(line) # TODO
        # 'I N M - Create a new M x N image with all pixels coloured white (O)'
      when 'C'
        # 'C - Clears the table, setting all pixels to white (O)'
      when 'L'
        # 'L X Y C - Colours the pixel (X,Y) with colour C'
      when 'V'
        # 'V X Y1 Y2 C - Draw a vertical segment of colour C in column X between rows Y1 and Y2 (inclusive).'
      when 'H'
        # 'H X1 X2 Y C - Draw a horizontal segment of colour C in row Y between columns X1 and X2 (inclusive).'
      when 'S'
        # 'Show the contents of the current image'
      else
        fail_with_error('Unrecognised command', line)
      end
    end

  rescue InvalidInputError => e
    warn(e)
  end

  private

  def validate_line_i(line)
    arguments = line.split
    fail_with_error('Wrong number of arguments', line) unless arguments.count == 3
    fail_with_error('Unrecognised command', line) unless arguments[0] == 'I'
    arguments[1..2].each do |coordinate|
      unless coordinate =~ /\A\d{1,3}\z/ && coordinate.to_i.between?(1, 250)
        fail_with_error('Input invalid or out of range (1-250)', line)
      end
    end
  end

  def fail_with_error(message, line)
    raise(InvalidInputError, "ERROR - #{message}: '#{line}'")
  end
end
