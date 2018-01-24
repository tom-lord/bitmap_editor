require 'spec_helper'

describe 'BitmapImage' do
  subject { BitmapImage.new(height, width) }
  let(:width) { 3 }
  let(:height) { 2 }

  describe '#data' do
    it 'initializes with correct dimensions in white (O)' do
      expect(subject.data).to eq(
        [
          %w[O O O],
          %w[O O O]
        ]
      )
    end
  end

  describe '#show' do
    it 'prints the bitmap to stdout' do
      expect { subject.show }.to output(
        <<~OUTPUT
          O O O
          O O O
        OUTPUT
      ).to_stdout
    end
  end

  describe '#change_pixel' do
    it 'prints the bitmap to stdout' do
      subject.change_pixel(2, 1, 'X')
      expect(subject.data).to eq(
        [
          %w[O X O],
          %w[O O O]
        ]
      )
    end
  end
end
