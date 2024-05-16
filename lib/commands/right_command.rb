module Commands
  class RightCommand < BaseCommand
    def execute(robot, _table)
      return unless robot.placed?

      robot.right
    end
  end
end
