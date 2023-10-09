class CardsRemoveColumnOneLeftLines < ActiveRecord::Migration[7.0]
  def change
    remove_column :cards, :one_left_lines
  end
end
