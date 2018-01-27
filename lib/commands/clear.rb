module Commands
  class Clear < Base
    private

    def validate
      super(command: 'C', arg_count: 1)
    end

    def update_image
      @image.clear
    end
  end
end
