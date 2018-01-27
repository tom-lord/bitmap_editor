module Commands
  class ChangePixel < Base
    private

    def validate
      super(command: 'L', arg_count: 4)
      validate_coordinates(*arguments[1..2])
      validate_colour(arguments[3])
      validate_within_canvas(arguments[1], arguments[2])
    end

    def perform
      image.change_pixel(*arguments_without_command)
    end
  end
end
