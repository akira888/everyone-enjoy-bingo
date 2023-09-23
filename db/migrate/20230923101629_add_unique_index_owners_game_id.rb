class AddUniqueIndexOwnersGameId < ActiveRecord::Migration[7.0]
  def change
    add_index :owners, :game_id, unique: true
  end
end
