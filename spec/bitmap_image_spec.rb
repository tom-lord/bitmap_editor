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
end
