require_relative 'cell'

# Class implements methods for easier manipulation with grid
class Grid
  attr_reader :size
  attr_reader :sub_size

  def initialize
    @size = 0
    @sub_size = 0
    @rows = Array.new
  end

  def cell_at(cell_index)
    @rows[cell_index / @size.to_i][cell_index % @size.to_i]
  end

  def load_from_file(file_path)
    File.open(file_path, 'r').each_line do |line|
      puts line
      @rows.push(
        line.split.collect do |value|
          value = value.to_i
          if value > 0
            Cell.new(value, 9, true)
          else
            Cell.new(nil, 9)
          end
        end
      )
    end
    @size = @rows.count
    @sub_size = Math.sqrt(@size)
  end

  def first
    (0..(@size * @size - 1)).each do |index|
      return index, cell_at(index) unless cell_at(index).predefined?
    end
    nil
  end

  def next_(cell_index)
    (cell_index + 1..(@size * @size - 1)).each do |index|
      return index, cell_at(index) unless cell_at(index).predefined?
    end
    [nil, nil]
  end

  def pred_(cell_index)
    (0..cell_index - 1).reverse_each do |index|
      return index, cell_at(index) unless cell_at(index).predefined?
    end
    [nil, nil]
  end

  def value_allowed?(cell_index, value)
    row_index = cell_index / @size.to_i
    column_index = cell_index % @size.to_i
    return false if row_contains_value?(row_index, value)
    return false if column_contains_value?(column_index, value)
    return false if subgrid_contains_value?(row_index, column_index, value)
    true
  end

  def row_contains_value?(row_index, value)
    (0..@size - 1).each do |column_index|
      return true if @rows[row_index][column_index].value == value
    end
    false
  end

  def column_contains_value?(column_index, value)
    (0..@size - 1).each do |row_index|
      return true if @rows[row_index][column_index].value == value
    end
    false
  end

  def subgrid_contains_value?(row_index, column_index, value)
    start_row_index = row_index - (row_index % @sub_size)
    start_column_index = column_index - (column_index % @sub_size)
    end_row_index = start_row_index + @sub_size - 1
    end_column_index = start_column_index + @sub_size - 1
    @rows[start_row_index..end_row_index].each do |row|
      row[start_column_index..end_column_index].each do |cell|
        return true if cell.value == value
      end
    end
    false
  end

  def to_s
    output = ''
    @rows.each do |row|
      output += row.collect { |column| column.to_s }.join(' ') + "\n"
    end
    output
  end
end
