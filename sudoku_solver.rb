require_relative 'grid'

class SudokuSolver
  attr_reader :grid

  def initialize
    @grid = Grid.new
  end

  def solve_brute_force
    cell_index, cell = @grid.first
    until cell.nil?
      cell_value = cell.increment
      if cell_value == false
        cell.empty!
        cell_index, cell = @grid.pred_(cell_index)
      else
        if @grid.value_allowed?(cell_index, cell_value)
          cell.increment!
          cell_index, cell = @grid.next_(cell_index)
        else
          cell.increment!
        end
      end
    end
  end
end

sudoku = SudokuSolver.new
puts "The playing field:\n"
sudoku.grid.load_from_file('sudoku/sudoku_field.txt')
sudoku.solve_brute_force
str = sudoku.grid.to_s
puts "\nSolution:\n#{str}"
file = File.new("sudoku/sudoku_solution.txt", "a:UTF-8")
file.print(str)
