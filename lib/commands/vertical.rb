module Commands
  class Vertical < Base
    private

    def validate
      super(command: 'V', arg_count: 5)
      validate_coordinates(*arguments[1..3])
      validate_colour(arguments[4])
      validate_within_canvas(arguments[1], arguments[3])
      fail_with_error('Invalid range') if arguments[2].to_i > arguments[3].to_i
    end

    def perform
      image.change_vertical(*arguments_without_command)
    end
  end
end
