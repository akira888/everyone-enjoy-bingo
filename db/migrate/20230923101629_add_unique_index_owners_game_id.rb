class AddUniqueIndexOwnersGameId < ActiveRecord::Migration[7.0]
  def change
    add_index :owners, :game_id, unique: true, name: 'unique_index_on_game_id'
  end
end
