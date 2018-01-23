class BitmapEditor
  def run(file)
    return puts 'please provide correct file' if file.nil? || !File.exist?(file)

    File.open(file).each do |line|
      line = line.chomp
      case line
      when 'I'
        puts 'I N M - Create a new M x N image with all pixels coloured white (O)'
      when 'C'
        puts 'C - Clears the table, setting all pixels to white (O)'
      when 'L'
        puts 'L X Y C - Colours the pixel (X,Y) with colour C'
      when 'V'
        puts 'V X Y1 Y2 C - Draw a vertical segment of colour C in column X between rows Y1 and Y2 (inclusive).'
      when 'H'
        puts 'H X1 X2 Y C - Draw a horizontal segment of colour C in row Y between columns X1 and X2 (inclusive).'
      when 'S'
        puts 'Show the contents of the current image'
      else
        puts 'unrecognised command :('
      end
    end
  end
end
