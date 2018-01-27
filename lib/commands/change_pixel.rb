module Commands
  class ChangePixel < Base
    private

    def validate
      super(command: 'L', arg_count: 4)
      arguments[1..2].each do |coordinate|
        unless coordinate =~ /\A\d{1,3}\z/ && coordinate.to_i.between?(1, BitmapEditor::MAX_DIMENSION)
          fail_with_error("Input invalid or out of range (1-#{BitmapEditor::MAX_DIMENSION})")
        end
      end
      fail_with_error('Invalid colour') unless arguments[3] =~ /\A[A-Z]\z/
      fail_with_error('Outside current canvas') if arguments[1].to_i > @image.width
      fail_with_error('Outside current canvas') if arguments[2].to_i > @image.height
    end

    def perform
      image.change_pixel(*arguments_without_command)
    end
  end
end
