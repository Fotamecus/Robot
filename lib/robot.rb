class Robot
  DIRECTIONS = %i[NORTH EAST SOUTH WEST].freeze

  attr_reader :x, :y, :direction

  def placed?
    !@x.nil? && !@y.nil? && !@direction.nil?
  end

  def place(x, y, direction)
    @x = x
    @y = y
    @direction = direction.to_sym
  end

  def move
    case @direction
    when :NORTH then @y += 1
    when :EAST then @x += 1
    when :SOUTH then @y -= 1
    when :WEST then @x -= 1
    end
  end

  def left
    @direction = DIRECTIONS[(DIRECTIONS.index(@direction) - 1) % 4]
  end

  def right
    @direction = DIRECTIONS[(DIRECTIONS.index(@direction) + 1) % 4]
  end
end
    