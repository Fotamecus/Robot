module Commands
  class RightCommand < BaseCommand
    def execute(robot, _table)
      unless robot.placed?
        puts 'Robot has not been placed'
        return
      end

      robot.right
    end
  end
end
