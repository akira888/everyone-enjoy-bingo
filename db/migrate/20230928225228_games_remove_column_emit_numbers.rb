class GamesRemoveColumnEmitNumbers < ActiveRecord::Migration[7.0]
  def change
    remove_column :games, :emit_numbers, :json
  end
end
