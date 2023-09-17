class CreateGames < ActiveRecord::Migration[7.0]
  def change
    create_table :games do |t|
      t.string :title
      t.integer :max_winners, limit: 2, null: false, default: 1
      t.integer :max_players, limit: 3, null: false, default: 1
      t.integer :entry_period_minutes, limit: 2, null: false, default: 5
      t.datetime :started_at
      t.datetime :finished_at
      t.boolean :random_awards, null: false, default: false
      t.json :emit_numbers
      t.string :players_url_hash, null: false
      t.string :owners_url_hash, null: false

      t.timestamps
    end
  end
end
