require 'spec_helper'

RSpec.describe Commands::LeftCommand do
  let(:robot) { Robot.new }
  let(:table) { Table.new(5, 5) }
  let(:left_command) { Commands::LeftCommand.new }

  describe '#execute' do
    subject(:left_command_execute) { left_command.execute(robot, table) }

    context 'when the robot is placed' do
      before { allow(robot).to receive(:placed?).and_return(true) }

      it 'turns the robot left' do
        expect(robot).to receive(:left)

        left_command_execute
      end
    end

    context 'when the robot is not placed' do
      before { allow(robot).to receive(:placed?).and_return(false) }
      
      it 'does not turn the robot left' do
        expect(robot).not_to receive(:left)

        left_command_execute
      end

      it 'outputs a message' do
        expect(STDOUT).to receive(:puts).with('Robot has not been placed')

        left_command_execute
      end
    end
  end
end
