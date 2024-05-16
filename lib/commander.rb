require_relative 'table'
require_relative 'robot'
Dir[File.expand_path('../commands/*.rb', __FILE__)].each { |file| require file }

class Commander
  def initialize
    @table = Table.new(5, 5)
    @robot = Robot.new
  end

  def execute(command_string)
    command = parse_command(command_string)
    command&.execute(@robot, @table)
  end

  private

  def parse_command(command_string)
    parts = command_string.split
    case parts[0]
    when 'PLACE'
      x, y, direction = parts[1].split(',')
      Commands::PlaceCommand.new(x.to_i, y.to_i, direction)
    when 'MOVE'
      Commands::MoveCommand.new
    when 'LEFT'
      Commands::LeftCommand.new
    when 'RIGHT'
      Commands::RightCommand.new
    when 'REPORT'
      Commands::ReportCommand.new
    else
      nil
    end
  end
end
