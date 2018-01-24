require 'spec_helper'

describe 'BitmapEditor#run with invalid input' do
  subject { BitmapEditor.new.run(input_file) }
  let(:input_file) do
    Tempfile.new.tap do |file|
      file.write(input_string)
      file.rewind
    end
  end

  context 'initialize and show' do
    let(:input_string) do
      <<~INPUT
        I 2 3
        S
      INPUT
    end
    let(:expected_output) do
      <<~OUTPUT
        O O O
        O O O
      OUTPUT
    end

    it 'prints expected output to stdout' do
      expect { subject }.to output(expected_output).to_stdout
    end
  end
end
