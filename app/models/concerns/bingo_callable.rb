module BingoCallable
  def count_bingo_lines(card_numbers)
    count = 0
    count += count_bingo_horizontal(card_numbers.values)
    count += count_bingo_vertical(card_numbers.values)
    count + count_bingo_diagonal(card_numbers)
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
    count += 1 if matrix["b"][0] == 'x' && matrix["i"][1] == 'x' && matrix["n"][2] == 'x' && matrix["g"][3] == 'x' && matrix["o"][4] == 'x'
    count += 1 if matrix["b"][4] == 'x' && matrix["i"][3] == 'x' && matrix["n"][2] == 'x' && matrix["g"][1] == 'x' && matrix["o"][0] == 'x'
    count
  end
end
