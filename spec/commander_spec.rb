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
      before { allow(commander).to receive(:valid_place_args?).and_return(true) }

      context 'when the command has more than one part' do
        let(:command_string) { 'PLACE 0,0,NORTH' }

        it 'calls the valid_place_args? method' do
          expect(commander).to receive(:valid_place_args?).with('0', '0', 'NORTH')

          parse_command
        end

        it 'returns a PlaceCommand instance' do
          expect(parse_command).to be_a(Commands::PlaceCommand)
        end
      end

      context 'when the command has only one part' do
        let(:command_string) { 'PLACE' }

        it 'does not call the valid_place_args? method' do
          expect(commander).not_to receive(:valid_place_args?)

          parse_command
        end

        it 'outputs a message' do
          expect(STDOUT).to receive(:puts).with("Invalid PLACE command - expected arguments: PLACE X,Y,DIRECTION")

          parse_command
        end

        it 'returns nil' do
          expect(parse_command).to be_nil
        end
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

      it 'outputs a message' do
        expect(STDOUT).to receive(:puts).with("Invalid command: #{command_string}")

        parse_command
      end

      it 'returns nil' do
        expect(parse_command).to be_nil
      end
    end
  end

  describe '#valid_place_args?' do
    subject(:valid_place_args?) { commander.send(:valid_place_args?, x, y, direction) }

    context 'when the x argument is valid' do
      let(:x) { '0' }

      context 'when the y argument is valid' do
        let(:y) { '0' }

        context 'when the direction argument is valid' do
          let(:direction) { 'NORTH' }

          it 'returns true' do
            expect(valid_place_args?).to be true
          end
        end

        context 'when the direction argument is invalid' do
          let(:direction) { 'INVALID' }

          it 'outputs a message' do
            expect(STDOUT).to receive(:puts).with("Invalid direction argument: #{direction}")
            
            valid_place_args?
          end

          it 'returns false' do
            expect(valid_place_args?).to be false
          end
        end
      end

      context 'when the y argument is invalid' do
        let(:y) { 'INVALID' }
        let(:direction) { 'NORTH' }

        it 'outputs a message' do
          expect(STDOUT).to receive(:puts).with("Invalid y argument: #{y}")

          valid_place_args?
        end

        it 'returns false' do
          expect(valid_place_args?).to be false
        end
      end
    end

    context 'when the x argument is invalid' do
      let(:x) { 'INVALID' }
      let(:y) { '0' }
      let(:direction) { 'NORTH' }

      it 'outputs a message' do
        expect(STDOUT).to receive(:puts).with("Invalid x argument: #{x}")

        valid_place_args?
      end

      it 'returns false' do
        expect(valid_place_args?).to be false
      end
    end
  end
end
