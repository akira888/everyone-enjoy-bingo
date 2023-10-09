class PlayersRemoveColumnOneLeftLinesAndBingoLines < ActiveRecord::Migration[7.0]
  def change
    remove_column :players, :one_left_lines
    remove_column :players, :bingo_lines
  end
end
