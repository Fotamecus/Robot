module Commands
  class LeftCommand < BaseCommand
    def execute(robot, _table)
      return unless robot.placed?

      robot.left
    end
  end
end
