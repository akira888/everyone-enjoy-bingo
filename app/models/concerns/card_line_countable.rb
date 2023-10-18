module CardLineCountable
  def count_marked_lines(card_numbers)
    @new_bingo_lines = 0
    @new_one_left_lines = 0

    counter = Proc.new do |marks|
      @new_one_left_lines += 1 if marks == 4
      @new_bingo_lines += 1 if marks == 5
    end
    count_marks_by_horizontal(card_numbers.values, &counter)
    count_marks_by_vertical(card_numbers.values, &counter)
    count_mark_by_diagonal(card_numbers, &counter)
  end

  def new_bingo_lines = @new_bingo_lines
  def new_one_left_lines = @new_one_left_lines

  private

  def count_marks_by_horizontal(matrix)
    matrix.each do |row|
      count = row.count { |cell| cell == 'x' }
      yield count
    end
  end

  def count_marks_by_vertical(matrix)
    matrix.transpose.each do |row|
      count = row.count { |cell| cell == 'x' }
      yield count
    end
  end

  # 対角線をカウントする
  def count_mark_by_diagonal(matrix)
    [
      [matrix["b"][0], matrix["i"][1], matrix["n"][2], matrix["g"][3], matrix["o"][4]],
      [matrix["b"][4], matrix["i"][3], matrix["n"][2], matrix["g"][1], matrix["o"][0]],
    ].each do |row|
      count = row.count { |cell| cell == 'x' }
      yield count
    end
  end
end
