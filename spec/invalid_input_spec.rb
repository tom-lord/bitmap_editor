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

    context '2nd arg not integer' do
      let(:input_string) { 'I 1xx 1' }
      it { expect { subject }.to output(/invalid or out of range/).to_stderr }
    end

    context '2nd arg less than 1' do
      let(:input_string) { 'I 0 1' }
      it { expect { subject }.to output(/invalid or out of range/).to_stderr }
    end

    context '2nd arg greater than 250' do
      let(:input_string) { 'I 251 1' }
      it { expect { subject }.to output(/invalid or out of range/).to_stderr }
    end

    context '3rd arg not integer' do
      let(:input_string) { 'I 1 1xx' }
      it { expect { subject }.to output(/invalid or out of range/).to_stderr }
    end

    context '3rd arg less than 1' do
      let(:input_string) { 'I 1 0' }
      it { expect { subject }.to output(/invalid or out of range/).to_stderr }
    end

    context '3rd arg greater than 250' do
      let(:input_string) { 'I 1 251' }
      it { expect { subject }.to output(/invalid or out of range/).to_stderr }
    end
  end # context 'arguments for "I"'

  context 'arguments for "C"' do
    context 'additional characters on command' do
      let(:input_string) { 'Cx' }
      it { expect { subject }.to output(/Unrecognised command/).to_stderr }
    end

    context 'more than 1 argument' do
      let(:input_string) { 'C x' }
      it { expect { subject }.to output(/Unrecognised command/).to_stderr }
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

  # let(:input_string) do
  #   <<~INPUT
  #     ...
  #   INPUT
  # end
end
