class Table
  attr_reader :width, :height

  def initialize(width, height)
    @width = width
    @height = height
  end

  def within_bounds?(x, y)
    x.between?(0, @width - 1) && y.between?(0, @height - 1)
  end
end
