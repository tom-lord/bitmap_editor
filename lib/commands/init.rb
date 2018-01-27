module Commands
  class Init < Base
    private

    def validate
      super(command: 'I', arg_count: 3)
      validate_coordinates(*arguments[1..2])
    end

    def perform
      @image = BitmapImage.new(*arguments_without_command)
    end
  end
end
