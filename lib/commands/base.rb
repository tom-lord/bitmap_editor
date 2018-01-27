module Commands
  class Base
    def initialize(line, image)
      @line = line
      @image = image
    end

    def call
      validate
      update_image
      @image
    end

    protected

    def validate(command:, arg_count:)
      fail_with_error('Unrecognised command') unless arguments[0] == command
      fail_with_error('Wrong number of arguments') unless arguments.count == arg_count
    end

    def arguments
      @arguments ||= @line.split
    end

    def fail_with_error(message)
      raise(InvalidInputError, "ERROR - #{message}: '#{@line}'")
    end
  end
end
