module Commands
  class Base
    attr_reader :line, :image
    def initialize(line, image)
      @line = line
      @image = image
    end

    def call
      validate
      perform
      image
    end

    protected

    def validate(command:, arg_count:)
      fail_with_error('Unrecognised command') unless arguments[0] == command
      fail_with_error('Wrong number of arguments') unless arguments.count == arg_count
    end

    def validate_coordinates(*coordinates)
      coordinates.each do |coordinate|
        unless coordinate =~ /\A\d{1,3}\z/ && coordinate.to_i.between?(1, BitmapEditor::MAX_DIMENSION)
          fail_with_error("Input invalid or out of range (1-#{BitmapEditor::MAX_DIMENSION})")
        end
      end
    end

    def validate_colour(colour)
      fail_with_error('Invalid colour') unless colour =~ /\A[A-Z]\z/
    end

    def validate_within_canvas(max_width, max_height)
      fail_with_error('Outside current canvas') if max_width.to_i > @image.width || max_height.to_i > @image.height
    end

    def arguments
      @arguments ||= line.split
    end

    def arguments_without_command
      arguments[1..-1]
    end

    def fail_with_error(message)
      raise(BitmapEditor::InvalidInputError, "ERROR - #{message}: '#{line}'")
    end
  end
end
