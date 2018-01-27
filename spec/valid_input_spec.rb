require 'spec_helper'

describe 'BitmapEditor#run with invalid input' do
  subject { BitmapEditor.new.run(input_file) }
  let(:input_file) do
    Tempfile.new.tap do |file|
      file.write(input_string)
      file.rewind
    end
  end

  def self.run_valid_output_spec
    it 'prints expected output to stdout' do
      expect { subject }.to output(expected_output).to_stdout
    end
  end

  context 'initialize and show' do
    let(:input_string) do
      <<~INPUT
        I 3 2
        S
      INPUT
    end
    let(:expected_output) do
      <<~OUTPUT
        OOO
        OOO
      OUTPUT
    end
    run_valid_output_spec
  end

  context 'initialize, change pixel and show' do
    let(:input_string) do
      <<~INPUT
        I 3 2
        L 2 1 X
        S
      INPUT
    end
    let(:expected_output) do
      <<~OUTPUT
        OXO
        OOO
      OUTPUT
    end
    run_valid_output_spec
  end

  context 'initialize, change pixel, clear and show' do
    let(:input_string) do
      <<~INPUT
        I 3 2
        L 2 1 X
        C
        S
      INPUT
    end
    let(:expected_output) do
      <<~OUTPUT
        OOO
        OOO
      OUTPUT
    end
    run_valid_output_spec
  end

  context 'initialize, change vertical and show' do
    let(:input_string) do
      <<~INPUT
        I 3 2
        V 3 1 2 X
        S
      INPUT
    end
    let(:expected_output) do
      <<~OUTPUT
        OOX
        OOX
      OUTPUT
    end
    run_valid_output_spec
  end

  context 'initialize, change horizontal and show' do
    let(:input_string) do
      <<~INPUT
        I 3 2
        H 2 3 2 X
        S
      INPUT
    end
    let(:expected_output) do
      <<~OUTPUT
        OOO
        OXX
      OUTPUT
    end
    run_valid_output_spec
  end
end
