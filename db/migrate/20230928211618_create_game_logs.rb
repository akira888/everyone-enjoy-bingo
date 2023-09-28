class CreateGameLogs < ActiveRecord::Migration[7.0]
  def change
    create_table :game_logs do |t|
      t.references :game, null: false, foreign_key: true
      t.integer :emit_number, limit: 2, null: false

      t.timestamps
    end
  end
end
