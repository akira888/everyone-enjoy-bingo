class CreateWinners < ActiveRecord::Migration[7.0]
  def change
    create_table :winners do |t|
      t.references :game, null: false, foreign_key: true
      t.references :award, null: false, foreign_key: true
      t.references :user, null: false, foreign_key: true
      t.text :message

      t.timestamps
    end
  end
end
