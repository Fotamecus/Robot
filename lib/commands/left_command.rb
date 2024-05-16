module Commands
  class LeftCommand < BaseCommand
    def execute(robot, _table)
      unless robot.placed?
        puts 'Robot has not been placed'
        return
      end

      robot.left
    end
  end
end
