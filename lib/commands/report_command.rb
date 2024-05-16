module Commands
  class ReportCommand < BaseCommand
    def execute(robot, _table)
      unless robot.placed?
        puts 'Robot has not been placed'
        return
      end

      puts "#{robot.x},#{robot.y},#{robot.direction}"
    end
  end
end
