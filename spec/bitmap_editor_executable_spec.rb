require 'spec_helper'

describe 'bin/bitmap_editor' do
  let(:expected_output) do
    <<~OUTPUT
      O O O O O O O O O O O O O O O O O O O O O O O O O O O O O O O O O O O O O O O O O O O O O O O O O O O O O O O O O O O O O O O O O O O O O O O O O O O O O O O O O O O O O O O O O O O O O O O O O O O O
      O O O O O O O O O O O O O O O O O O O O O O O O O O O O O O O O O O O O O O O O O O O O O O O O O O O O O O O O O O O O O O O O O O O O O O O O O O O O O O O O O O O O O O O O O O O O O O O O O O O O
      O O O O O O O O O O O O O O O O O O O O O O O O O O O O O O O O O O O O O O O O O O O O O O O O O O O O O O O O O O O O O O O O O O O O O O O O O O O O O O O O O O O O O O O O O O O O O O O O O O O O
      O O O O O O O O B B B B B B B B B B O O O B B B B B B B B B O O O B B B B B B B B B B B B B B B O O O B B B B O O O B B B B O O B B B B B B B B B O O B B B B B O O O B B B B O O O O B B B B O O O O O
      O O O O O O O B B B B B B B B B B B B B B B B B B B B B B B B O O B B B B B B B B B B O B B B B O O B B B B B B O O B B B B B B B B B B B B B B B B B B B B B B O O B B B B B O O B B B B B B O O O O O
      O O O O O O B B B B B O O O O B B O B B B B B B O O O O B B B B O B B B B B B O O O O O B B B B B B B B B B B B B B B B B B B B B B O O O O O B B B B B B B B B B O B B B B B B B B B B B O O O O O O O
      O O O O O B B B B B O O O O O O O O B B B B B O O O O O B B B B B B B B B O O O O O O O O B B B B B B B B B B B B B B B B B B B B B O O O O O O B B B B B B B B B B B B B B B B B B B B B O O O O O O O
      O O O O O O B B B B B O O O O B O O B B B B B B O O O B B B B B B B B B B O O O O O O O O B B B B B B B B B B B B B B B B O B B B B B O O O O B B B B B O B B B B B B B B B B B B B B B O O O O O O O O
      O O O O O O O B B B B B B B B B B B B B B B B B B B B B B B B B B B B B B O O O O O O O O O B B B B B B O O B B B B B O O O O B B B B B B B B B B B B B O O B B B B B B O B B B B B B B O O O O O O O O
      O O O O O O O O B B B B B B B B B B O O B B B B B B B B B B B B O B B B B O O O O O O O O O O B B B B B O O B B B B O O O O O O B B B B B B B B B O O O O O O B B B B O O O B B B B O O O O O O O O O O
      O O O O O O O O O O O O O O O O O O O O O O O O O O O O O O O O O O O O O O O O O O O O O O O O O O O O O O O O O O O O O O O O O O O O O O O O O O O O O O O O O O O O O O O O O O O O O O O O O O O O
      O O O O O O O O O O O O O O O O O O O O O O O O O O O O O O O O O O O O O O O O O O O O O O O O O O O O O O O O O O O O O O O O O O O O O O O O O O O O O O O O O O O O O O O O O O O O O O O O O O O O
      O O O O O O O O O O O O O O O O O O O O O O O O O O O O O O O O O O O O O O O O O O O O O O O O O O O O O O O O O O O O O O O O O O O O O O O O O O O O O O O O O O O O O O O O O O O O O O O O O O O O
    OUTPUT
  end
  it 'executes successfully and displays output' do
    expect { system('bin/bitmap_editor examples/mystery_image.txt') }
      .to output(expected_output).to_stdout_from_any_process
  end
end
