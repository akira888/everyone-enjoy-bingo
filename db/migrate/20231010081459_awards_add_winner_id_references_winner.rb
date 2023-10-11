class AwardsAddWinnerIdReferencesWinner < ActiveRecord::Migration[7.0]
  def change
    add_reference :awards, :winner, foreign_key: true, null: true, after: :game_id
  end
end
