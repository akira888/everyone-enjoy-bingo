class CreateCards < ActiveRecord::Migration[7.0]
  def change
    create_table :cards do |t|
      t.references :player, null: false, foreign_key: true
      t.json :numbers
      t.integer :one_left_lines
      t.integer :bingo_lines

      t.timestamps
    end
  end
end
