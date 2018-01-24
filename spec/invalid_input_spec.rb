require 'spec_helper'

describe 'BitmapEditor#run with invalid input' do
  subject { BitmapEditor.new.run(input_file) }
  let(:input_file) do
    Tempfile.new.tap do |file|
      file.write(input_string)
      file.rewind
    end
  end

  context 'invalid command' do
    let(:input_string) { 'banana' }
    it { expect { subject }.to output(/Unrecognised command/).to_stderr }
  end

  context 'arguments for "I"' do
    context 'additional characters on command' do
      let(:input_string) { 'Ix 1 1' }
      it { expect { subject }.to output(/Unrecognised command/).to_stderr }
    end

    context 'too many arguments' do
      let(:input_string) { 'I 1 2 3' }
      it { expect { subject }.to output(/Wrong number of arguments/).to_stderr }
    end

    context 'too few arguments' do
      let(:input_string) { 'I 1' }
      it { expect { subject }.to output(/Wrong number of arguments/).to_stderr }
    end

    [2, 3].each do |number|
      context "arg ##{number} is not an integer" do
        let(:input_string) do
          args = %w[I 1 1]
          args[number - 1] = '1xx'
          args.join(' ') # e.g. 'I 1xx 1'
        end
        it { expect { subject }.to output(/invalid or out of range/).to_stderr }
      end

      context "arg ##{number} is less than 1" do
        let(:input_string) do
          args = %w[I 1 1]
          args[number - 1] = '0'
          args.join(' ') # e.g. 'I 0 1'
        end
        it { expect { subject }.to output(/invalid or out of range/).to_stderr }
      end

      context "arg ##{number} is greater than 250" do
        let(:input_string) do
          args = %w[I 1 1]
          args[number - 1] = '251'
          args.join(' ') # e.g. 'I 251 1'
        end
        it { expect { subject }.to output(/invalid or out of range/).to_stderr }
      end
    end
  end # context 'arguments for "I"'

  context 'arguments for "C"' do
    context 'additional characters on command' do
      let(:input_string) { 'Cx' }
      it { expect { subject }.to output(/Unrecognised command/).to_stderr }
    end

    context 'more than 1 argument' do
      let(:input_string) { 'C x' }
      it { expect { subject }.to output(/Wrong number of arguments/).to_stderr }
    end
  end # context 'arguments for "C"'

  context 'arguments for "L"' do
    context 'additional characters on command' do
      let(:input_string) { 'Lx 1 1 B' }
      it { expect { subject }.to output(/Unrecognised command/).to_stderr }
    end

    context 'too many arguments' do
      let(:input_string) { 'L 1 1 B x' }
      it { expect { subject }.to output(/Wrong number of arguments/).to_stderr }
    end

    context 'too few arguments' do
      let(:input_string) { 'L 1 1' }
      it { expect { subject }.to output(/Wrong number of arguments/).to_stderr }
    end

    context 'not a valid colour (upper case letter)' do
      let(:input_string) { 'L 1 1 xxx' }
      it { expect { subject }.to output(/Invalid colour/).to_stderr }
    end
  end # context 'arguments for "L"'

  context 'arguments for "V"' do
    context 'additional characters on command' do
      let(:input_string) { 'Vx 1 1 1 B' }
      it { expect { subject }.to output(/Unrecognised command/).to_stderr }
    end

    context 'too many arguments' do
      let(:input_string) { 'V 1 1 1 B x' }
      it { expect { subject }.to output(/Wrong number of arguments/).to_stderr }
    end

    context 'too few arguments' do
      let(:input_string) { 'V 1 1 1' }
      it { expect { subject }.to output(/Wrong number of arguments/).to_stderr }
    end

    context 'not a valid colour (upper case letter)' do
      let(:input_string) { 'V 1 1 1 xxx' }
      it { expect { subject }.to output(/Invalid colour/).to_stderr }
    end
  end # context 'arguments for "V"'

  context 'arguments for "H"' do
    context 'additional characters on command' do
      let(:input_string) { 'Hx 1 1 1 B' }
      it { expect { subject }.to output(/Unrecognised command/).to_stderr }
    end

    context 'too many arguments' do
      let(:input_string) { 'H 1 1 1 B x' }
      it { expect { subject }.to output(/Wrong number of arguments/).to_stderr }
    end

    context 'too few arguments' do
      let(:input_string) { 'H 1 1 1' }
      it { expect { subject }.to output(/Wrong number of arguments/).to_stderr }
    end

    context 'not a valid colour (upper case letter)' do
      let(:input_string) { 'H 1 1 1 xxx' }
      it { expect { subject }.to output(/Invalid colour/).to_stderr }
    end
  end # context 'arguments for "H"'

  context 'arguments for "S"' do
    context 'additional characters on command' do
      let(:input_string) { 'Sx' }
      it { expect { subject }.to output(/Unrecognised command/).to_stderr }
    end

    context 'more than 1 argument' do
      let(:input_string) { 'S x' }
      it { expect { subject }.to output(/Wrong number of arguments/).to_stderr }
    end
  end # context 'arguments for "S"'

  # let(:input_string) do
  #   <<~INPUT
  #     ...
  #   INPUT
  # end
end
