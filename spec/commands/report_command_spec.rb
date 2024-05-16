require 'spec_helper'

RSpec.describe Commands::ReportCommand do
  let(:robot) { Robot.new }
  let(:table) { Table.new(5, 5) }
  let(:report_command) { Commands::ReportCommand.new }

  describe '#execute' do
    subject(:report_command_execute) { report_command.execute(robot, table) }

    context 'when the robot is placed' do
      before do
        allow(robot).to receive(:placed?).and_return(true)
        allow(robot).to receive(:x).and_return(2)
        allow(robot).to receive(:y).and_return(4)
        allow(robot).to receive(:direction).and_return(:NORTH)
      end

      it 'reports the robot position' do
        expect(STDOUT).to receive(:puts).with('2,4,NORTH')

        report_command_execute
      end
    end

    context 'when the robot is not placed' do
      before { allow(robot).to receive(:placed?).and_return(false) }

      it 'reports an error' do
        expect(STDOUT).to receive(:puts).with('Robot has not been placed')

        report_command_execute
      end
    end
  end
end