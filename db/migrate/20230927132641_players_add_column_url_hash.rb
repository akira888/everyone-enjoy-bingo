class PlayersAddColumnUrlHash < ActiveRecord::Migration[7.0]
  def change
    add_column :players, :url_hash, :string, null: false, default: '', after: :id
    add_index :players, :url_hash, unique: true
  end
end
