module Commands
  class ChangePixel < Base
    private

    def validate
      super(command: 'L', arg_count: 4)
      validate_coordinates(*arguments[1..2])
      validate_colour(arguments[3])
      fail_with_error('Outside current canvas') if arguments[1].to_i > @image.width
      fail_with_error('Outside current canvas') if arguments[2].to_i > @image.height
    end

    def perform
      image.change_pixel(*arguments_without_command)
    end
  end
end
