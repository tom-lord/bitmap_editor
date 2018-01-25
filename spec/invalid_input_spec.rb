require 'spec_helper'

describe 'BitmapEditor#run with invalid input' do
  subject { BitmapEditor.new.run(input_file) }
  let(:input_file) do
    Tempfile.new.tap do |file|
      file.write(input_string)
      file.rewind
    end
  end
  # Note: All files must start with I command
  # therefore most of these tests is for the SECOND line in the file
  let(:input_string) do
    <<~INPUT
      I 10 10
      #{test_input_line}
    INPUT
  end

  def command_mutator(command, number_to_change, change_value)
    args = command.split
    args[number_to_change - 1] = change_value
    args.join(' ')
  end

  context 'invalid command' do
    let(:test_input_line) { 'banana' }
    it { expect { subject }.to output(/Unrecognised command/).to_stderr }
  end

  context 'arguments for "I"' do
    context 'additional characters on command' do
      let(:test_input_line) { 'Ix 1 1' }
      it { expect { subject }.to output(/Unrecognised command/).to_stderr }
    end

    context 'too many arguments' do
      let(:test_input_line) { 'I 1 2 3' }
      it { expect { subject }.to output(/Wrong number of arguments/).to_stderr }
    end

    context 'too few arguments' do
      let(:test_input_line) { 'I 1' }
      it { expect { subject }.to output(/Wrong number of arguments/).to_stderr }
    end

    [2, 3].each do |number|
      context "arg ##{number} is not an integer" do
        let(:test_input_line) do
          command_mutator('I 1 1', number, '1xx')
        end
        it { expect { subject }.to output(/invalid or out of range/).to_stderr }
      end

      context "arg ##{number} is less than 1" do
        let(:test_input_line) do
          command_mutator('I 1 1', number, '0')
        end
        it { expect { subject }.to output(/invalid or out of range/).to_stderr }
      end

      context "arg ##{number} is greater than 250" do
        let(:test_input_line) do
          command_mutator('I 1 1', number, '251')
        end
        it { expect { subject }.to output(/invalid or out of range/).to_stderr }
      end
    end
  end # context 'arguments for "I"'

  context 'arguments for "C"' do
    context 'additional characters on command' do
      let(:test_input_line) { 'Cx' }
      it { expect { subject }.to output(/Unrecognised command/).to_stderr }
    end

    context 'more than 1 argument' do
      let(:test_input_line) { 'C x' }
      it { expect { subject }.to output(/Wrong number of arguments/).to_stderr }
    end
  end # context 'arguments for "C"'

  context 'arguments for "L"' do
    context 'additional characters on command' do
      let(:test_input_line) { 'Lx 1 1 B' }
      it { expect { subject }.to output(/Unrecognised command/).to_stderr }
    end

    context 'too many arguments' do
      let(:test_input_line) { 'L 1 1 B x' }
      it { expect { subject }.to output(/Wrong number of arguments/).to_stderr }
    end

    context 'too few arguments' do
      let(:test_input_line) { 'L 1 1' }
      it { expect { subject }.to output(/Wrong number of arguments/).to_stderr }
    end

    context 'not a valid colour (upper case letter)' do
      let(:test_input_line) { 'L 1 1 xxx' }
      it { expect { subject }.to output(/Invalid colour/).to_stderr }
    end

    [2, 3].each do |number|
      context "arg ##{number} is not an integer" do
        let(:test_input_line) do
          command_mutator('L 1 1 B', number, '1xx')
        end
        it { expect { subject }.to output(/invalid or out of range/).to_stderr }
      end

      context "arg ##{number} is less than 1" do
        let(:test_input_line) do
          command_mutator('L 1 1 B', number, '0')
        end
        it { expect { subject }.to output(/invalid or out of range/).to_stderr }
      end

      context "arg ##{number} is greater than 250" do
        let(:test_input_line) do
          command_mutator('L 1 1 B', number, '251')
        end
        it { expect { subject }.to output(/invalid or out of range/).to_stderr }
      end
    end

    context 'x coordinate outside current canvas' do
      let(:test_input_line) { 'L 11 1 B' }
      it { expect { subject }.to output(/Outside current canvas/).to_stderr }
    end

    context 'y coordinate outside current canvas' do
      let(:test_input_line) { 'L 1 11 B' }
      it { expect { subject }.to output(/Outside current canvas/).to_stderr }
    end
  end # context 'arguments for "L"'

  context 'arguments for "V"' do
    context 'additional characters on command' do
      let(:test_input_line) { 'Vx 1 1 1 B' }
      it { expect { subject }.to output(/Unrecognised command/).to_stderr }
    end

    context 'too many arguments' do
      let(:test_input_line) { 'V 1 1 1 B x' }
      it { expect { subject }.to output(/Wrong number of arguments/).to_stderr }
    end

    context 'too few arguments' do
      let(:test_input_line) { 'V 1 1 1' }
      it { expect { subject }.to output(/Wrong number of arguments/).to_stderr }
    end

    context 'not a valid colour (upper case letter)' do
      let(:test_input_line) { 'V 1 1 1 xxx' }
      it { expect { subject }.to output(/Invalid colour/).to_stderr }
    end

    [2, 3, 4].each do |number|
      context "arg ##{number} is not an integer" do
        let(:test_input_line) do
          command_mutator('V 1 1 1 B', number, '1xx')
        end
        it { expect { subject }.to output(/invalid or out of range/).to_stderr }
      end

      context "arg ##{number} is less than 1" do
        let(:test_input_line) do
          command_mutator('V 1 1 1 B', number, '0')
        end
        it { expect { subject }.to output(/invalid or out of range/).to_stderr }
      end

      context "arg ##{number} is greater than 250" do
        let(:test_input_line) do
          command_mutator('V 1 1 1 B', number, '251')
        end
        it { expect { subject }.to output(/invalid or out of range/).to_stderr }
      end
    end

    context 'x coordinate outside current canvas' do
      let(:test_input_line) { 'V 11 1 1 B' }
      it { expect { subject }.to output(/Outside current canvas/).to_stderr }
    end

    context 'y2 coordinate outside current canvas' do
      let(:test_input_line) { 'V 1 1 11 B' }
      it { expect { subject }.to output(/Outside current canvas/).to_stderr }
    end

    context 'y1 coordinate greater than y2' do
      let(:test_input_line) { 'V 1 2 1 B' }
      it { expect { subject }.to output(/Invalid range/).to_stderr }
    end
  end # context 'arguments for "V"'

  context 'arguments for "H"' do
    context 'additional characters on command' do
      let(:test_input_line) { 'Hx 1 1 1 B' }
      it { expect { subject }.to output(/Unrecognised command/).to_stderr }
    end

    context 'too many arguments' do
      let(:test_input_line) { 'H 1 1 1 B x' }
      it { expect { subject }.to output(/Wrong number of arguments/).to_stderr }
    end

    context 'too few arguments' do
      let(:test_input_line) { 'H 1 1 1' }
      it { expect { subject }.to output(/Wrong number of arguments/).to_stderr }
    end

    context 'not a valid colour (upper case letter)' do
      let(:test_input_line) { 'H 1 1 1 xxx' }
      it { expect { subject }.to output(/Invalid colour/).to_stderr }
    end

    [2, 3, 4].each do |number|
      context "arg ##{number} is not an integer" do
        let(:test_input_line) do
          command_mutator('H 1 1 1 B', number, '1xx')
        end
        it { expect { subject }.to output(/invalid or out of range/).to_stderr }
      end

      context "arg ##{number} is less than 1" do
        let(:test_input_line) do
          command_mutator('H 1 1 1 B', number, '0')
        end
        it { expect { subject }.to output(/invalid or out of range/).to_stderr }
      end

      context "arg ##{number} is greater than 250" do
        let(:test_input_line) do
          command_mutator('H 1 1 1 B', number, '251')
        end
        it { expect { subject }.to output(/invalid or out of range/).to_stderr }
      end
    end

    context 'y coordinate outside current canvas' do
      let(:test_input_line) { 'H 11 1 1 B' }
      it { expect { subject }.to output(/Outside current canvas/).to_stderr }
    end

    context 'x2 coordinate outside current canvas' do
      let(:test_input_line) { 'H 1 1 11 B' }
      it { expect { subject }.to output(/Outside current canvas/).to_stderr }
    end

    context 'x1 coordinate greater than x2' do
      let(:test_input_line) { 'H 1 2 1 B' }
      it { expect { subject }.to output(/Invalid range/).to_stderr }
    end
  end # context 'arguments for "H"'

  context 'arguments for "S"' do
    context 'additional characters on command' do
      let(:test_input_line) { 'Sx' }
      it { expect { subject }.to output(/Unrecognised command/).to_stderr }
    end

    context 'more than 1 argument' do
      let(:test_input_line) { 'S x' }
      it { expect { subject }.to output(/Wrong number of arguments/).to_stderr }
    end
  end # context 'arguments for "S"'

  context 'file does not start with I command' do
    let(:input_string) { 'S' }
    it { expect { subject }.to output(/First command must be "I"/).to_stderr }
  end
end
