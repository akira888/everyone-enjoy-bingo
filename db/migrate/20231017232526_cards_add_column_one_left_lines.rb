class CardsAddColumnOneLeftLines < ActiveRecord::Migration[7.0]
  def change
    add_column :cards, :one_left_lines, :integer, default: 0, null: false, after: :bingo_lines
  end
end
