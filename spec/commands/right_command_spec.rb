require 'spec_helper'

RSpec.describe Commands::RightCommand do
  let(:robot) { Robot.new }
  let(:table) { Table.new(5, 5) }
  let(:right_command) { Commands::RightCommand.new }

  describe '#execute' do
    subject(:right_command_execute) { right_command.execute(robot, table) }

    context 'when the robot is placed' do
      before { allow(robot).to receive(:placed?).and_return(true) }

      it 'turns the robot right' do
        expect(robot).to receive(:right)

        right_command_execute
      end
    end

    context 'when the robot is not placed' do
      before { allow(robot).to receive(:placed?).and_return(false) }

      it 'does not turn the robot right' do
        expect(robot).not_to receive(:right)

        right_command_execute
      end

      it 'outputs a message' do
        expect(STDOUT).to receive(:puts).with('Robot has not been placed')

        right_command_execute
      end
    end
  end
end
