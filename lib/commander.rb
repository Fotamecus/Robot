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
      if parts.length < 2
        puts 'Invalid PLACE command - expected arguments: PLACE X,Y,DIRECTION'
        return nil
      end

      x, y, direction = parts[1].split(',')

      return unless valid_place_args?(x, y, direction)

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
      puts "Invalid command: #{command_string}"
      nil
    end
  end

  def valid_place_args?(x, y, direction)
    if x.nil? || (false if Float(x) rescue true)
      puts "Invalid x argument: #{x}"
      return false
    end

    if y.nil? || (false if Float(y) rescue true)
      puts "Invalid y argument: #{y}"
      return false
    end

    if direction.nil? || !Robot::DIRECTIONS.include?(direction.to_sym)
      puts "Invalid direction argument: #{direction}"
      return false
    end

    true
  end
end
