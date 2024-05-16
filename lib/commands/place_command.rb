module Commands
  class PlaceCommand < BaseCommand
    def initialize(x, y, direction)
      @x = x
      @y = y
      @direction = direction
    end

    def execute(robot, table)
      return unless table.within_bounds?(@x, @y)

      robot.place(@x, @y, @direction)
    end
  end
end
