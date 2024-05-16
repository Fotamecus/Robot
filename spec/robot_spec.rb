require 'spec_helper'

RSpec.describe Robot do
  let(:robot) { Robot.new }

  describe '#initialize' do
    it 'creates a new robot' do
      expect(robot).to be_a Robot
    end

    it 'has a nil x' do
      expect(robot.x).to be_nil
    end

    it 'has a nil y' do
      expect(robot.y).to be_nil
    end

    it 'has a nil direction' do
      expect(robot.direction).to be_nil
    end
  end

  describe '#placed?' do
    context 'when the robot has been placed' do
      before { robot.place(1, 2, :NORTH) }

      it 'returns true' do
        expect(robot.placed?).to be true
      end
    end

    context 'when the robot has not been placed' do
      it 'returns false' do
        expect(robot.placed?).to be false
      end
    end
  end

  describe '#place' do
    subject(:place_robot) { robot.place(1, 2, :NORTH) }

    it 'assigns an x' do
      place_robot

      expect(robot.x).to eq 1
    end

    it 'assigns a y' do
      place_robot

      expect(robot.y).to eq 2
    end

    it 'assigns a direction' do
      place_robot

      expect(robot.direction).to eq :NORTH
    end
  end

  describe '#move' do
    context 'when the robot is facing NORTH' do
      before { robot.place(1, 2, :NORTH) }

      it 'moves the robot one unit north' do
        robot.move

        expect(robot.y).to eq 3
      end
    end

    context 'when the robot is facing EAST' do
      before { robot.place(1, 2, :EAST) }

      it 'moves the robot one unit east' do
        robot.move

        expect(robot.x).to eq 2
      end
    end

    context 'when the robot is facing SOUTH' do
      before { robot.place(1, 2, :SOUTH) }

      it 'moves the robot one unit south' do
        robot.move

        expect(robot.y).to eq 1
      end
    end

    context 'when the robot is facing WEST' do
      before { robot.place(1, 2, :WEST) }

      it 'moves the robot one unit west' do
        robot.move

        expect(robot.x).to eq 0
      end
    end
  end

  describe '#left' do
    context 'when the robot is facing NORTH' do
      before { robot.place(1, 2, :NORTH) }

      it 'rotates the robot to face WEST' do
        robot.left

        expect(robot.direction).to eq :WEST
      end
    end

    context 'when the robot is facing EAST' do
      before { robot.place(1, 2, :EAST) }

      it 'rotates the robot to face NORTH' do
        robot.left

        expect(robot.direction).to eq :NORTH
      end
    end

    context 'when the robot is facing SOUTH' do
      before { robot.place(1, 2, :SOUTH) }

      it 'rotates the robot to face EAST' do
        robot.left

        expect(robot.direction).to eq :EAST
      end
    end

    context 'when the robot is facing WEST' do
      before { robot.place(1, 2, :WEST) }

      it 'rotates the robot to face SOUTH' do
        robot.left

        expect(robot.direction).to eq :SOUTH
      end
    end
  end

  describe '#right' do
    context 'when the robot is facing NORTH' do
      before { robot.place(1, 2, :NORTH) }

      it 'rotates the robot to face EAST' do
        robot.right

        expect(robot.direction).to eq :EAST
      end
    end

    context 'when the robot is facing EAST' do
      before { robot.place(1, 2, :EAST) }

      it 'rotates the robot to face SOUTH' do
        robot.right

        expect(robot.direction).to eq :SOUTH
      end
    end

    context 'when the robot is facing SOUTH' do
      before { robot.place(1, 2, :SOUTH) }

      it 'rotates the robot to face WEST' do
        robot.right

        expect(robot.direction).to eq :WEST
      end
    end

    context 'when the robot is facing WEST' do
      before { robot.place(1, 2, :WEST) }

      it 'rotates the robot to face NORTH' do
        robot.right

        expect(robot.direction).to eq :NORTH
      end
    end
  end
end
