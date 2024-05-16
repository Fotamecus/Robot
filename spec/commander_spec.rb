require 'spec_helper'

RSpec.describe Commander do
  let(:commander) { Commander.new }

  describe '#initialize' do
    it 'initializes a new table' do
      expect(commander.instance_variable_get(:@table)).to be_a(Table)
    end

    it 'initializes a new robot' do
      expect(commander.instance_variable_get(:@robot)).to be_a(Robot)
    end
  end

  describe '#execute' do
    subject(:execute) { commander.execute(command_string) }

    let(:command) { instance_double(Commands::PlaceCommand) }

    before do
      allow(command).to receive(:execute)
    end

    context 'when the command exists' do
      let(:command_string) { 'PLACE 0,0,NORTH' }

      before do
        allow(commander).to receive(:parse_command).and_return(command)
      end

      it 'calls the parse_command method' do
        expect(commander).to receive(:parse_command).with(command_string)

        execute
      end

      it 'executes the command' do
        expect(command).to receive(:execute)

        execute
      end
    end

    context 'when the command does not exist' do
      let(:command_string) { 'INVALID' }
      
      before do
        allow(commander).to receive(:parse_command).and_return(nil)
      end

      it 'calls the parse_command method' do
        expect(commander).to receive(:parse_command).with(command_string)

        execute
      end

      it 'does not execute the command' do
        expect(command).not_to receive(:execute)

        execute
      end
    end
  end

  describe '#parse_command' do
    subject(:parse_command) { commander.send(:parse_command, command_string) }

    context 'when the command is PLACE' do
      let(:command_string) { 'PLACE 0,0,NORTH' }

      it 'returns a PlaceCommand instance' do
        expect(parse_command).to be_a(Commands::PlaceCommand)
      end
    end

    context 'when the command is MOVE' do
      let(:command_string) { 'MOVE' }

      it 'returns a MoveCommand instance' do
        expect(parse_command).to be_a(Commands::MoveCommand)
      end
    end

    context 'when the command is LEFT' do
      let(:command_string) { 'LEFT' }

      it 'returns a LeftCommand instance' do
        expect(parse_command).to be_a(Commands::LeftCommand)
      end
    end

    context 'when the command is RIGHT' do
      let(:command_string) { 'RIGHT' }

      it 'returns a RightCommand instance' do
        expect(parse_command).to be_a(Commands::RightCommand)
      end
    end

    context 'when the command is REPORT' do
      let(:command_string) { 'REPORT' }

      it 'returns a ReportCommand instance' do
        expect(parse_command).to be_a(Commands::ReportCommand)
      end
    end

    context 'when the command is invalid' do
      let(:command_string) { 'INVALID' }

      it 'returns nil' do
        expect(parse_command).to be_nil
      end
    end
  end
end
