class CardsChangeColumnBingoLinesDefaultZero < ActiveRecord::Migration[7.0]
  def change
    change_column_default :cards, :bingo_lines, 0
  end
end
