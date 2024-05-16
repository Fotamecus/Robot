module Commands
  class PlaceCommand < BaseCommand
    def initialize(x, y, direction)
      @x = x
      @y = y
      @direction = direction
    end

    def execute(robot, table)
      unless table.within_bounds?(@x, @y)
        puts 'Position out of bounds'
        return
      end

      robot.place(@x, @y, @direction)
    end
  end
end
