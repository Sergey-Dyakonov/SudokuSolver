# Class represents one cell in sudoku grid
class Cell
  attr_accessor :value
  attr_reader :predefined

  def initialize(value, max_value = 9, predefined = false)
    @max_value = max_value
    @value = value
    @predefined = predefined
  end

  def predefined?
    @predefined
  end

  def empty?
    @value.nil? ? true : false
  end

  def empty!
    @value = nil
  end

  def to_s
    empty? ? '?' : @value.to_s
  end

  def increment
    if empty?
      1
    else
      if @value == @max_value
        false
      else
        @value.next
      end
    end
  end

  def increment!
    @value = self.increment
  end
end
