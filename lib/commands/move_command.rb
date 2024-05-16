module Commands
  class MoveCommand < BaseCommand
    def execute(robot, table)
      unless robot.placed?
        puts 'Robot has not been placed'
        return
      end

      new_x, new_y = next_position(robot)
      if table.within_bounds?(new_x, new_y)
        robot.move
      else
        puts 'Move out of bounds'
      end
    end

    private

    def next_position(robot)
      case robot.direction
      when :NORTH then [robot.x, robot.y + 1]
      when :EAST then [robot.x + 1, robot.y]
      when :SOUTH then [robot.x, robot.y - 1]
      when :WEST then [robot.x - 1, robot.y]
      end
    end
  end
end
