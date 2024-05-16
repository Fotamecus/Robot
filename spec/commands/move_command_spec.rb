require 'spec_helper'

RSpec.describe Commands::MoveCommand do
  let(:robot) { Robot.new }
  let(:table) { Table.new(5, 5) }
  let(:move_command) { Commands::MoveCommand.new }

  describe '#execute' do
    subject(:move_command_execute) { move_command.execute(robot, table) }

    context 'when the robot is placed' do
      before { robot.place(0, 0, :NORTH) }

      context 'when the move is within bounds' do
        before { allow(table).to receive(:within_bounds?).and_return(true) }

        it 'moves the robot' do
          expect(robot).to receive(:move)

          move_command_execute
        end
      end

      context 'when the move is out of bounds' do
        before { allow(table).to receive(:within_bounds?).and_return(false) }

        it 'does not move the robot' do
          expect(robot).not_to receive(:move)

          move_command_execute
        end

        it 'outputs a message' do
          expect(STDOUT).to receive(:puts).with('Move out of bounds')

          move_command_execute
        end
      end
    end

    context 'when the robot is not placed' do
      it 'does not move the robot' do
        expect(robot).not_to receive(:move)

        move_command_execute
      end

      it 'outputs a message' do
        expect(STDOUT).to receive(:puts).with('Robot has not been placed')

        move_command_execute
      end
    end
  end

  describe '#next_position' do
    subject(:next_position) { move_command.send(:next_position, robot) }

    context 'when the robot is facing NORTH' do
      before { robot.place(2, 2, :NORTH) }

      it 'returns the correct position' do
        expect(next_position).to eq [2, 3]
      end
    end

    context 'when the robot is facing EAST' do
      before { robot.place(2, 2, :EAST) }

      it 'returns the correct position' do
        expect(next_position).to eq [3, 2]
      end
    end

    context 'when the robot is facing SOUTH' do
      before { robot.place(2, 2, :SOUTH) }

      it 'returns the correct position' do
        expect(next_position).to eq [2, 1]
      end
    end

    context 'when the robot is facing WEST' do
      before { robot.place(2, 2, :WEST) }

      it 'returns the correct position' do
        expect(next_position).to eq [1, 2]
      end
    end
  end
end
