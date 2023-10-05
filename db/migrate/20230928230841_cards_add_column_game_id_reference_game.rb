class CardsAddColumnGameIdReferenceGame < ActiveRecord::Migration[7.0]
  def change
    add_reference :cards, :game, foreign_key: true, null: false, after: :player_id
  end
end
