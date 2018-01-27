module Commands
  class Show < Base
    private

    def validate
      super(command: 'S', arg_count: 1)
    end

    def perform
      image.show
    end
  end
end
