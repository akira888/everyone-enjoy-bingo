class AddIndexGamesHasUrlHashesUniqueness < ActiveRecord::Migration[7.0]
  def change
    add_index :games, :players_url_hash, unique: true
    add_index :games, :owners_url_hash, unique: true
  end
end
