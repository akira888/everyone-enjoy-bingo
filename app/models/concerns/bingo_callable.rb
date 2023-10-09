module BingoCallable
  def count_bingo_lines(card)
    count = 0
    count += count_bingo_horizontal(card.values)
    count += count_bingo_vertical(card.values)
    count + count_bingo_diagonal(card.values)
  end

  def count_bingo_horizontal(matrix)
    count = 0
    matrix.each do |row|
      count += 1 if row.all? { |cell| cell == 'x' }
    end
    count
  end

  def count_bingo_vertical(matrix)
    count = 0
    matrix.transpose.each do |row|
      count += 1 if row.all? { |cell| cell == 'x' }
    end
    count
  end

  def count_bingo_diagonal(matrix)
    count = 0
    count += 1 if matrix[0][0] == 'x' && matrix[1][1] == 'x' && matrix[2][2] == 'x' && matrix[3][3] == 'x' && matrix[4][4] == 'x'
    count += 1 if matrix[0][4] == 'x' && matrix[1][3] == 'x' && matrix[2][2] == 'x' && matrix[3][1] == 'x' && matrix[4][0] == 'x'
    count
  end
end
