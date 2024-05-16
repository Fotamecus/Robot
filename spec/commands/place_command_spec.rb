require 'spec_helper'

RSpec.describe Commands::PlaceCommand do
  let(:robot) { Robot.new }
  let(:table) { Table.new(5, 5) }
  let(:place_command) { Commands::PlaceCommand.new(1, 2, :NORTH) }

  describe '#initialize' do
    it 'creates a new PlaceCommand' do
      expect(place_command).to be_a Commands::PlaceCommand
    end

    it 'assigns an x' do
      expect(place_command.instance_variable_get(:@x)).to eq 1
    end

    it 'assigns a y' do
      expect(place_command.instance_variable_get(:@y)).to eq 2
    end

    it 'assigns a direction' do
      expect(place_command.instance_variable_get(:@direction)).to eq :NORTH
    end
  end

  describe '#execute' do
    subject(:place_command_execute) { place_command.execute(robot, table) }

    context 'when the position is within bounds' do
      before { allow(table).to receive(:within_bounds?).and_return(true) }

      it 'places the robot' do
        expect(robot).to receive(:place)

        place_command_execute
      end
    end

    context 'when the position is out of bounds' do
      before { allow(table).to receive(:within_bounds?).and_return(false) }

      it 'does not place the robot' do
        expect(robot).not_to receive(:place)

        place_command_execute
      end

      it 'outputs a message' do
        expect(STDOUT).to receive(:puts).with('Position out of bounds')

        place_command_execute
      end
    end
  end
end
