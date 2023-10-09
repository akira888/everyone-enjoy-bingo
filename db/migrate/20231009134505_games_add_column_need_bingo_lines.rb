class GamesAddColumnNeedBingoLines < ActiveRecord::Migration[7.0]
  def change
    add_column :games, :need_bingo_lines, :integer, default: 1, limit: 2, null: false
  end
end
