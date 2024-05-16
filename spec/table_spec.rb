require 'spec_helper'

RSpec.describe Table do
  let(:table) { Table.new(5, 5) }

  describe '#initialize' do
    it 'creates a new table' do
      expect(table).to be_a Table
    end

    it 'has the correct width' do
      expect(table.width).to eq 5
    end

    it 'has the correct height' do
      expect(table.height).to eq 5
    end
  end

  describe '#within_bounds?' do
    it 'returns true for a valid position' do
      expect(table.within_bounds?(0, 0)).to be true
    end

    it 'returns false for a position with a negative x' do
      expect(table.within_bounds?(-1, 0)).to be false
    end

    it 'returns false for a position with a negative y' do
      expect(table.within_bounds?(0, -1)).to be false
    end

    it 'returns false for a position with an x greater than the width' do
      expect(table.within_bounds?(5, 0)).to be false
    end

    it 'returns false for a position with a y greater than the height' do
      expect(table.within_bounds?(0, 5)).to be false
    end
  end
end
