class CreateGames < ActiveRecord::Migration[7.0]
  def change
    create_table :games do |t|
      t.string :title
      t.integer :max_winners
      t.integer :max_players
      t.integer :entry_period_minutes
      t.datetime :started_at
      t.datetime :finished_at
      t.boolean :random_awards
      t.json :emit_numbers

      t.timestamps
    end
  end
end
