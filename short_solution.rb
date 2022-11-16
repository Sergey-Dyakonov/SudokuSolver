$sudoku = [[5, 3, 0, 0, 7, 0, 0, 0, 0],
           [6, 0, 0, 1, 9, 5, 0, 0, 0],
           [0, 9, 8, 0, 0, 0, 0, 6, 0],
           [8, 0, 0, 0, 6, 0, 0, 0, 3],
           [4, 0, 0, 8, 0, 3, 0, 0, 1],
           [7, 0, 0, 0, 2, 0, 0, 0, 6],
           [0, 6, 0, 0, 0, 0, 2, 8, 0],
           [0, 0, 0, 4, 1, 9, 0, 0, 5],
           [0, 0, 0, 0, 8, 0, 0, 7, 9]]

def print_grid
  (0..8).each { |row|
    (0..8).each { |col|
      print $sudoku[row][col].to_s + " "
      if col == 2 or col == 5
        print "| "
      end
    }
    print "\n"
    if row == 2 or row == 5
      print "------+-------+------\n"
    end
  }
end

def is_valid_column?(col, num)
  0.upto(8) do |row|
    if $sudoku[row][col] == num
      return false
    end
  end
  true
end

def is_valid_row?(row, num)
  ($sudoku[row] - [num]).length == 9
end

def is_valid_subgrid?(row, col, num)
  start_row = row / 3 * 3
  start_column = col / 3 * 3
  center = $sudoku[start_row][start_column..start_column + 2] +
    $sudoku[start_row + 1][start_column..start_column + 2] +
    $sudoku[start_row + 2][start_column..start_column + 2]
  (center - [num]).length == 9
end

def is_valid?(row, col, num)
  is_valid_subgrid?(row, col, num) && is_valid_row?(row, num) && is_valid_column?(col, num)
end

def solve(row, col)
  if row == 9
    return true
  end
  if col == 9
    return solve(row + 1, 0)
  end
  if $sudoku[row][col] != 0
    return solve(row, col + 1)
  end
  1.upto(9) do |value|
    # 1.upto(9)   #=> 1 2 3 4 5 .....
    if is_valid?(row, col, value)
      $sudoku[row][col] = value
      if solve(row, col + 1)
        return true
      end
      $sudoku[row][col] = 0
    end
  end
  false
end

puts "Result:"
if solve(0, 0)
  print_grid
else
  print "No solution."
  exit
end
