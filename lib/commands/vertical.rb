module Commands
  class Vertical < Base
    private

    def validate
      super(command: 'V', arg_count: 5)
      arguments[1..3].each do |coordinate|
        unless coordinate =~ /\A\d{1,3}\z/ && coordinate.to_i.between?(1, BitmapEditor::MAX_DIMENSION)
          fail_with_error("Input invalid or out of range (1-#{BitmapEditor::MAX_DIMENSION})")
        end
      end
      fail_with_error('Invalid colour') unless arguments[4] =~ /\A[A-Z]\z/
      fail_with_error('Outside current canvas') if arguments[1].to_i > @image.width
      fail_with_error('Outside current canvas') if arguments[3].to_i > @image.height
      fail_with_error('Invalid range') if arguments[2].to_i > arguments[3].to_i
    end

    def update_image
      image.change_vertical(*arguments_without_command)
    end
  end
end
