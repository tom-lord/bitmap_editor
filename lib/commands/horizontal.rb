module Commands
  class Horizontal < Base
    private

    def validate
      super(command: 'H', arg_count: 5)
      validate_coordinates(*arguments[1..3])
      validate_colour(arguments[4])
      validate_within_canvas(arguments[2], arguments[3])
      fail_with_error('Invalid range') if arguments[1].to_i > arguments[2].to_i
    end

    def perform
      image.change_horizontal(*arguments_without_command)
    end
  end
end
