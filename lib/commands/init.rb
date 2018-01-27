module Commands
  class Init < Base
    private

    def validate
      super(command: 'I', arg_count: 3)
      arguments[1..2].each do |coordinate|
        unless coordinate =~ /\A\d{1,3}\z/ && coordinate.to_i.between?(1, BitmapEditor::MAX_DIMENSION)
          fail_with_error("Input invalid or out of range (1-#{BitmapEditor::MAX_DIMENSION})")
        end
      end
    end

    def update_image
      @image = BitmapImage.new(*arguments_without_command)
    end
  end
end
