module Commands
  class ReportCommand < BaseCommand
    def execute(robot, _table)
      return unless robot.placed?

      puts "#{robot.x},#{robot.y},#{robot.direction}"
    end
  end
end
