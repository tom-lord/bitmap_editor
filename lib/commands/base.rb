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
